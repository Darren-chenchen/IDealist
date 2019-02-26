//
//  BMScanController.h
//  BMScanDemo
//
//  Created by ___liangdahong on 2017/4/28.
//  Copyright © http://idhong.com All rights reserved.
//  Copyright © https://github.com/asiosldh/BMScan All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
typedef void(^BMPhotoAlbumQRCodeBlock)(NSArray <NSString *> *codeArray);

/**
 扫描控制器的基类
 */
@interface BMScanController : UIViewController

#pragma mark - 扫描响应

/**
 开始扫描
 */
- (void)startScanning NS_REQUIRES_SUPER;

/**
 结束扫描
 */
- (void)closureScanning NS_REQUIRES_SUPER;

/**
 扫描到内容时回调
 */
- (void)scanCaptureWithValueString:(NSString *)valueString NS_REQUIRES_SUPER;

#pragma mark - 配置信息

/**
 设置可以识别区域
 */
- (CGRect)rectOfInterest;

#pragma mark - 操作

/**
 刷新扫描
 */
- (void)reloadScan NS_REQUIRES_SUPER;

@property (assign, nonatomic) AVCaptureTorchMode torchMode; ///< torchMode
@property (nonatomic, assign, getter=isAudio) BOOL audio;   ///< 扫描到内容的提示音
@property (nonatomic, assign) SystemSoundID audioID;        ///< audioID

@end

#pragma mark -  二维码识别相关

/**
 二维码识别相关
 */
@interface NSObject (BMIdentify)

/**
 打开相册识别二维码
 */
+ (void)bm_identifyPhotoAlbumQRCodeWithResultsBlock:(BMPhotoAlbumQRCodeBlock)resultsBlock;

/**
 识别图片中的二维码
 */
+ (NSArray <NSString *> *)bm_codeArrayWithImage:(UIImage *)image;

@end
