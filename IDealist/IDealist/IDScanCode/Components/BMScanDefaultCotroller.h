//
//  BMScanDefaultCotroller.h
//  BMScanDemo
//
//  Created by ___liangdahong on 2017/4/28.
//  Copyright © http://idhong.com All rights reserved.
//  Copyright © https://github.com/asiosldh/BMScan All rights reserved.
//

#import "BMScanController.h"
/**
 参考系统动画 fillMode
 */
typedef NS_ENUM(NSUInteger, BMScanLinViewAnimation) {
    BMScanLinViewAnimationTypeCAFillModeForwards,
    BMScanLinViewAnimationTypeCAFillModeBackwards,
    BMScanLinViewAnimationTypeCAFillModeBoth,
    BMScanLinViewAnimationTypeCAFillModeRemoved,
};
/**
 扫描线条类型
 
 - IDScanLinTypeLin: 扫描线
 - IDScanLinTypeReticular1: 网状1
 - IDScanLinTypeReticular2: 网状2
 */
typedef NS_ENUM(NSUInteger, IDScanLin) {
    IDScanLinTypeLin,
    IDScanLinTypeReticular1,
    IDScanLinTypeReticular2,
};

/**
 包含UI 的扫描控制器
 */
@interface BMScanDefaultCotroller : BMScanController

#pragma mark - 标题label

@property (strong, nonatomic) UILabel *scanfTitleLabel; ///< 标题label
@property (strong, nonatomic) UILabel *titleLabel; ///< 标题label

#pragma mark - 配置信息

/**
 扫描区域 X 值
 */
- (CGFloat)areaX;

/**
 扫描区域 Y 值
 */
- (CGFloat)areaY;

/**
 扫描区域 Width 值
 */
- (CGFloat)areaWidth;

/**
 扫描区域 Height 值
 */
- (CGFloat)areaXHeight;

/**
 标题距扫描区域的距离
 */
- (CGFloat)areaTitleDistanceHeight;

/**
 非扫描区域的颜色
 */
- (UIColor *)areaColor;

/**
 脚颜色
 */
- (UIColor *)feetColor;

/**
 左上脚颜色
 */
- (UIColor *)leftTopColor;

/**
 左下脚颜色
 */
- (UIColor *)leftBottonColor;

/**
 右上脚颜色
 */
- (UIColor *)rightTop;

/**
 右下脚颜色
 */
- (UIColor *)rightBotton;

/**
 扫描线条颜色（扫描条或者什么网均可自定义颜色）
 */
- (UIColor *)scanfLin;

/**
 扫描线条动画
 */
- (BMScanLinViewAnimation)scanLinViewAnimation;

/**
 动画时间
 */
- (CFTimeInterval)animationDuration;

/**
 扫描线条类型
 */
- (IDScanLin)scanLin;

/**
 是否隐藏闪光灯按钮 默认打开
 */
- (BOOL)hidenLightButton;

@end
