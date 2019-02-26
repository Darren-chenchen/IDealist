//
//  BMScanController.m
//  BMScanDemo
//
//  Created by ___liangdahong on 2017/4/28.
//  Copyright © http://idhong.com All rights reserved.
//  Copyright © https://github.com/asiosldh/BMScan All rights reserved.
//

#import "BMScanController.h"
#import <objc/runtime.h>
#import <AudioToolbox/AudioToolbox.h>

#pragma mark - 私有C函数
CGRect screenBounds() {
    UIScreen *screen = [UIScreen mainScreen];
    if (![screen respondsToSelector:@selector(fixedCoordinateSpace)]
        && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        return CGRectMake(0, 0, CGRectGetHeight(screen.bounds), CGRectGetWidth(screen.bounds));
    }
    return screen.bounds;
}

AVCaptureVideoOrientation videoOrientationFromCurrentDeviceOrientation() {
    switch ([[UIApplication sharedApplication] statusBarOrientation]) {
        case UIInterfaceOrientationPortrait:
            return AVCaptureVideoOrientationPortrait;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            return AVCaptureVideoOrientationLandscapeLeft;
            break;
        case UIInterfaceOrientationLandscapeRight:
            return AVCaptureVideoOrientationLandscapeRight;
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            return AVCaptureVideoOrientationPortraitUpsideDown;
            break;
        default:
            return AVCaptureVideoOrientationPortrait;
            break;
    }
}

@interface BMScanController () <AVCaptureMetadataOutputObjectsDelegate>

@property (strong, nonatomic) AVCaptureDevice *device; ///< device
@property (strong, nonatomic) AVCaptureSession           *session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;
@property (strong, nonatomic) AVCaptureMetadataOutput    *output;

@end

@implementation BMScanController

#pragma mark -

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        _audioID = 1110;
        _audio = YES;
    }
    return self;
}

#pragma mark - 生命周期

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self startScanning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self closureScanning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]
        || authStatus == AVAuthorizationStatusRestricted
        || authStatus == AVAuthorizationStatusDenied) {
        NSLog(@"没有相机 或者 没有相机权限");
        return ;
    }
    [self creatScanning];
}

#pragma mark - getters setters

- (AVCaptureMetadataOutput *)output {
    if (!_output) {
        _output = [[AVCaptureMetadataOutput alloc] init];
        // 设置代理 在主线程里刷新
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        __weak typeof(self) wself = self;
        [[NSNotificationCenter defaultCenter] addObserverForName:AVCaptureInputPortFormatDescriptionDidChangeNotification
                                                          object:nil
                                                           queue:[NSOperationQueue mainQueue]
                                                      usingBlock: ^(NSNotification *_Nonnull note) {
                                                          __strong typeof(wself) self = wself;
                                                          self.output.rectOfInterest = [self.previewLayer metadataOutputRectOfInterestForRect:[self rectOfInterest]];
                                                      }];
    }
    return _output;
}

- (AVCaptureSession *)session {
    if (!_session) {
        _session = [AVCaptureSession new];
    }
    return _session;
}

- (AVCaptureVideoPreviewLayer *)previewLayer {
    if (!_previewLayer) {
        _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
        _previewLayer.videoGravity = AVLayerVideoGravityResize;
        // 必须添加
        _previewLayer.frame = screenBounds();
        _previewLayer.connection.videoOrientation = videoOrientationFromCurrentDeviceOrientation();
    }
    return _previewLayer;
}

- (void)setTorchMode:(AVCaptureTorchMode)torchMode {
    if (self.device && [self.device hasTorch]) {
        [self.device lockForConfiguration:nil];
        self.device.torchMode = torchMode;
        [self.device unlockForConfiguration];
    }
}

- (AVCaptureTorchMode)torchMode {
    return self.device.torchMode;
}

#pragma mark - 系统delegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects.count) {
        // 停止扫描
        if (metadataObjects.count) {
            [self closureScanning];
            AVMetadataMachineReadableCodeObject *metadataObject = metadataObjects[0];
            [self scanCaptureWithValueString:metadataObject.stringValue];
        }
        if (self.audio) {
            AudioServicesPlaySystemSound(self.audioID);
        }
    }
}

#pragma mark - 公有方法

- (void)startScanning {

    [self.session startRunning];
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
}

- (void)closureScanning {

    [self.session stopRunning];
    [self.previewLayer removeFromSuperlayer];
}

- (void)scanCaptureWithValueString:(NSString *)valueString {
    [self closureScanning];
}

- (CGRect)rectOfInterest {
    return self.view.bounds;
}

- (void)reloadScan {
    self.output.rectOfInterest = [self.previewLayer metadataOutputRectOfInterestForRect:[self rectOfInterest]];
}

#pragma mark - 私有方法

// 创建扫描
- (void)creatScanning {
    // 获取摄像设备
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];

    // 创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // 初始化链接对象
    self.session = [[AVCaptureSession alloc] init];
    
    // 高质量采集率
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    
    [self.session addInput:input];
    [self.session addOutput:self.output];

    // 设置扫码支持的编码格式
    self.output.metadataObjectTypes = @[
                                        AVMetadataObjectTypeUPCECode,
                                        AVMetadataObjectTypeCode39Code,
                                        AVMetadataObjectTypeCode39Mod43Code,
                                        AVMetadataObjectTypeEAN13Code,
                                        AVMetadataObjectTypeEAN8Code,
                                        AVMetadataObjectTypeCode93Code ,
                                        AVMetadataObjectTypeCode128Code ,
                                        AVMetadataObjectTypePDF417Code,
                                        AVMetadataObjectTypeQRCode,
                                        AVMetadataObjectTypeAztecCode];
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
}

@end

@interface BMIdentifyObject : NSObject <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

static const void * c1 = &c1;
static const void * c2 = &c2;

@implementation BMIdentifyObject

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    if (info[UIImagePickerControllerOriginalImage]) {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        BMPhotoAlbumQRCodeBlock block= objc_getAssociatedObject(self, c2);
        if (block) {
            block([NSObject bm_codeArrayWithImage:image]);
        }
    }
    objc_removeAssociatedObjects(self);
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
    objc_removeAssociatedObjects(self);
}

@end

@implementation  NSObject (BMIdentify)

+ (void)bm_identifyPhotoAlbumQRCodeWithResultsBlock:(BMPhotoAlbumQRCodeBlock)resultsBlock {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    BMIdentifyObject *identifyObject = [BMIdentifyObject new];
    imagePickerController.delegate = identifyObject;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    objc_setAssociatedObject(identifyObject, c1,   imagePickerController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(identifyObject, c2,   resultsBlock,          OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(identifyObject, _cmd, identifyObject,        OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    UIViewController *rootViewController = ((UIWindow *)[[[UIApplication sharedApplication] windows] objectAtIndex:0]).rootViewController;
    UIViewController *topViewController = rootViewController;
    while (topViewController.presentedViewController) {
        topViewController = topViewController.presentedViewController;
    }
    [rootViewController presentViewController:imagePickerController animated:YES completion:nil];
}

+ (NSArray <NSString *> *)bm_codeArrayWithImage:(UIImage *)image {
    NSData *imageData = UIImagePNGRepresentation(image);
    CIImage *ciImage = [CIImage imageWithData:imageData];
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy: CIDetectorAccuracyLow}];
    NSArray *feature = [detector featuresInImage:ciImage];
    NSMutableArray *muarray = [@[] mutableCopy];
    for (CIQRCodeFeature *result in feature) {
        [muarray addObject:result.messageString];
    }
    return [muarray copy];
}

@end
