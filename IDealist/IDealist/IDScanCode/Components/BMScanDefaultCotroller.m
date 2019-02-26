
//
//  BMScanDefaultCotroller.m
//  BMScanDemo
//
//  Created by ___liangdahong on 2017/4/28.
//  Copyright © http://idhong.com All rights reserved.
//  Copyright © https://github.com/asiosldh/BMScan All rights reserved.
//
#import "BMScanDefaultCotroller.h"
#import "BMDefaultUIView.h"
#import "UIImage+BMScan.h"
#import "BundleTools.h"

@interface BMScanDefaultCotroller ()

@property (strong, nonatomic) BMDefaultUIView *scanSettingView; ///< 扫描UI

@end

@implementation BMScanDefaultCotroller

#pragma mark -

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateScanUI];

    __weak typeof(self) weakSelf = self;
    self.scanSettingView.openLightBlock = ^{
        __strong typeof(weakSelf) self = weakSelf;
        if (self.torchMode == AVCaptureTorchModeOff) {
            self.torchMode = AVCaptureTorchModeOn;
            self.scanSettingView.openLightButton.selected = YES;
        } else {
            self.torchMode = AVCaptureTorchModeOff;
            self.scanSettingView.openLightButton.selected = NO;
        }
    };
}

#pragma mark - getters setters

- (BMDefaultUIView *)scanSettingView {
    if (!_scanSettingView) {
        _scanSettingView = [BMDefaultUIView defaultUIView];
    }
    return _scanSettingView;
}

- (UILabel *)scanfTitleLabel {
    return self.scanSettingView.scanTitleLabel;
}
- (UILabel *)titleLabel {
    return self.scanSettingView.titleLabel;
}

- (CGFloat)addConstraint {
    NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:self.scanSettingView.areaView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.scanSettingView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:self.scanSettingView.areaView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.scanSettingView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:-[self areaY]];
    [self.scanSettingView addConstraints:@[c1, c2]];
    return 0;
}

#pragma mark - 公有方法

- (void)startScanning {
    [super startScanning];
    [self.scanSettingView startAnimation];
}

- (void)closureScanning {
    [super closureScanning];
    self.scanSettingView.openLightButton.selected = NO;
    [self.scanSettingView stopAnimation];
}

- (void)scanCaptureWithValueString:(NSString *)valueString {
    [super scanCaptureWithValueString:valueString];
    self.scanSettingView.openLightButton.selected = NO;
    [self closureScanning];
}

- (CGRect)rectOfInterest {
    [self.view layoutIfNeeded];
    return self.scanSettingView.scanfAreaView.frame;
}

- (CGFloat)areaX {
    return [self addConstraint];
}

- (CGFloat)areaY {
    return [self addConstraint];
}

- (CGFloat)areaWidth {
    return 200;
}

- (CGFloat)areaXHeight {
    return 200;
}

- (CGFloat)areaTitleDistanceHeight {
    return 20;
}

- (UIColor *)areaColor {
    return nil;
}

- (UIColor *)feetColor {
    return nil;
}

- (UIColor *)leftTopColor {
    return nil;
}

- (UIColor *)leftBottonColor {
    return nil;
}

- (UIColor *)rightTop {
    return nil;
}

- (UIColor *)rightBotton {
    return nil;
}

- (UIColor *)scanfLin {
    return nil;
}

- (BMScanLinViewAnimation)scanLinViewAnimation {
    return BMScanLinViewAnimationTypeCAFillModeForwards;
}

- (CFTimeInterval)animationDuration {
    return (CGRectGetHeight(self.scanSettingView.areaView.frame) / 200.0) + 0.10;
}

- (IDScanLin)scanLin {
    return IDScanLinTypeLin;
}

- (BOOL)hidenLightButton {
    return NO;
}

- (void)updateScanUI {
    [self.view insertSubview:self.scanSettingView atIndex:1];
    self.scanSettingView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.scanSettingView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.scanSettingView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
    NSLayoutConstraint *bottonConstraint = [NSLayoutConstraint constraintWithItem:self.scanSettingView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.scanSettingView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
    [self.view addConstraints:@[topConstraint, leftConstraint, bottonConstraint, rightConstraint]];
    
    self.scanSettingView.feetImageView1.image = [UIImage bm_loadImageWithName:@"bm_scan_image_qr_corner_001_@2x"];
    self.scanSettingView.feetImageView2.image = [UIImage bm_loadImageWithName:@"bm_scan_image_qr_corner_002_@2x"];
    self.scanSettingView.feetImageView3.image = [UIImage bm_loadImageWithName:@"bm_scan_image_qr_corner_003_@2x"];
    self.scanSettingView.feetImageView4.image = [UIImage bm_loadImageWithName:@"bm_scan_image_qr_corner_004_@2x"];
    self.scanSettingView.scanfLinView.image   = [UIImage bm_loadImageWithName:@"bm_scan_image_qr_scan_line@2x"];
    
    self.scanSettingView.topLayoutConstraint.constant = [self areaY];
    self.scanSettingView.leftLayoutConstraint.constant = [self areaX];
    self.scanSettingView.widthLayoutConstraint.constant = [self areaWidth];
    self.scanSettingView.heightLayoutConstraint.constant = [self areaXHeight];
    self.scanSettingView.titleLabelBottonLayoutConstraint.constant = [self areaTitleDistanceHeight];
    
    UIColor *color1 = [self areaColor];
    if (color1) {
        [self.scanSettingView.backgroundViewArray enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.backgroundColor =  color1;
        }];
    }
    
    UIColor *color2 = [self feetColor];
    if (color2) {
        [self.scanSettingView.feetViewArray enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.image = [obj.image bm_imageWithColor:color2];
        }];
    }

    self.scanSettingView.feetImageView1.image = [self.scanSettingView.feetImageView1.image bm_imageWithColor:[self leftTopColor]];
    self.scanSettingView.feetImageView3.image = [self.scanSettingView.feetImageView3.image bm_imageWithColor:[self leftBottonColor]];
    self.scanSettingView.feetImageView2.image = [self.scanSettingView.feetImageView2.image bm_imageWithColor:[self rightTop]];
    self.scanSettingView.feetImageView4.image = [self.scanSettingView.feetImageView4.image bm_imageWithColor:[self rightBotton]];
    self.scanSettingView.scanLinViewAnimation = [self scanLinViewAnimation];
    IDScanLin scanLin = [self scanLin];
    self.scanSettingView.scanLin = scanLin;
    self.scanSettingView.animationDuration = [self animationDuration];
    switch (scanLin) {
        case IDScanLinTypeLin:
            self.scanSettingView.scanfLinView.image = [self.scanSettingView.scanfLinView.image bm_imageWithColor:[self scanfLin]];
            self.scanSettingView.scanImageView1.hidden = YES;

            break;
        case IDScanLinTypeReticular1:
            self.scanSettingView.scanImageView1.image = [[UIImage bm_loadImageWithName:@"qrcode_scan_full_net"] bm_imageWithColor:[self scanfLin]];
            self.scanSettingView.scanfLinView.hidden = YES;
            break;
        case IDScanLinTypeReticular2:
            self.scanSettingView.scanImageView1.image = [[UIImage bm_loadImageWithName:@"qrcode_scan_part_net"] bm_imageWithColor:[self scanfLin]];
            self.scanSettingView.scanfLinView.hidden = YES;
            break;
        default:
            break;
    }
    self.scanSettingView.openLightButton.hidden = [self hidenLightButton];
}

- (void)reloadScan {
    [self updateScanUI];
    [self.scanSettingView startAnimation];
    [super reloadScan];
}

@end
