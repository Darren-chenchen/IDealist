//
//  UIImage+BMScan.m
//  BMScanDemo
//
//  Created by __liangdahong on 2017/4/30.
//  Copyright © http://idhong.com All rights reserved.
//  Copyright © https://github.com/asiosldh/BMScan All rights reserved.
//

#import "UIImage+BMScan.h"
#import "BMScanController.h"
#import "BundleTools.h"
@implementation UIImage (BMScan)

- (NSArray<NSString *> *)bm_identifyCodeArray {
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh}];
    CIImage *image = [[CIImage alloc] initWithImage:self];
    NSArray <CIQRCodeFeature *> *features = (NSArray <CIQRCodeFeature *> *)[detector featuresInImage:image];
    NSMutableArray *codeArray = [@[] mutableCopy];
    [features enumerateObjectsUsingBlock:^(CIQRCodeFeature * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.messageString.length) {
            [codeArray addObject:obj.messageString];
        }
    }];
    return codeArray;
}

+ (instancetype)bm_imageWithBarCode:(NSString *)barCode maxSize:(CGSize)maxSize {
    
    if (!barCode || barCode.length == 0) return  nil;

    // 创建滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    
    // 恢复滤镜的默认属性
    [filter setDefaults];
    
    // 将字符串转换成NSData
    NSData *data = [barCode dataUsingEncoding:NSUTF8StringEncoding];
    
    // 通过KVO设置滤镜inputMessage数据
    [filter setValue:data forKey:@"inputMessage"];
    
    // 获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    
    // 将CIImage转换成UIImage
    return [self createNonInterpolatedUIImageFormCIImage:outputImage maxSize:maxSize];
}

+ (instancetype)bm_imageWithQRCode:(NSString *)qrCode maxSize:(CGSize)maxSize {
    
    if (!qrCode || qrCode.length == 0) return nil;
    
    // str -> NSData
    NSData *strData = [qrCode dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
    
    //创建二维码滤镜
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // KVO 设值
    [qrFilter setValue:strData forKey:@"inputMessage"];
    [qrFilter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    return [self createNonInterpolatedUIImageFormCIImage:qrFilter.outputImage maxSize:maxSize];
}

+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image maxSize:(CGSize)maxSize {
    // 取image的尺寸
    CGRect extent = CGRectIntegral(image.extent);
    if (CGRectGetWidth(extent) == 0 || CGRectGetHeight(extent) == 0)return nil;
    // 获取比例
    CGFloat scale = MIN(maxSize.width/CGRectGetWidth(extent), maxSize.height/CGRectGetHeight(extent));
    // 创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

- (UIImage *)bm_imageWithColor:(UIColor *)color {
    if (!color) {
        return self;
    }
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (instancetype)bm_loadImageWithName:(NSString *)name {
    
    NSBundle *bundle = [BundleTools getCurrentBundle];

    return [UIImage imageNamed:name inBundle:bundle compatibleWithTraitCollection:nil];
}

@end
