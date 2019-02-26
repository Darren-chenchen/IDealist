//
//  UIImage+BMScan.h
//  BMScanDemo
//
//  Created by __liangdahong on 2017/4/30.
//  Copyright © http://idhong.com All rights reserved.
//  Copyright © https://github.com/asiosldh/BMScan All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 工具类
 */
@interface UIImage (BMScan)

@property (copy, nonatomic, readonly) NSArray<NSString *> *bm_identifyCodeArray; ///< 识别图片中的二维码/条形码数据

/*!
 *  @brief 生成条形码
 *
 *  @param barCode 条形码字符串
 *  @param maxSize 最大size
 *
 *  @return 生成的条形码
 */
+ (instancetype)bm_imageWithBarCode:(NSString *)barCode maxSize:(CGSize)maxSize;

/*!
 *  @brief 生成二维码
 *
 *  @param qrCode      二维码字符串
 *  @param maxSize     最大size
 *
 *  @return 生成的二维码
 */
+ (instancetype)bm_imageWithQRCode:(NSString *)qrCode maxSize:(CGSize)maxSize;

#pragma mark -

/**
 由颜色创建image
 */
- (instancetype)bm_imageWithColor:(UIColor *)color;

/**
 加载image
 */
+ (instancetype)bm_loadImageWithName:(NSString *)name;

@end

