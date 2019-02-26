//
//  BMDefaultUIView.h
//  BMScanDemo
//
//  Created by ___liangdahong on 2017/4/28.
//  Copyright © http://idhong.com All rights reserved.
//  Copyright © https://github.com/asiosldh/BMScan All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMScanDefaultCotroller.h"
/**
 扫描UI
 */
@interface BMDefaultUIView : UIView

@property (strong, nonatomic) UIImageView *scanImageView1;                 ///< 扫描imageView
@property (assign, nonatomic) IDScanLin scanLin;                           ///< 扫描线动画类型
@property (assign, nonatomic) BMScanLinViewAnimation scanLinViewAnimation; ///< 扫描线动画类型
@property (assign, nonatomic) CFTimeInterval animationDuration;            ///< 动画时间
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLayoutConstraint;              ///< TopConstraint
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLayoutConstraint;             ///< leftLayoutConstraint
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthLayoutConstraint;            ///< widthLayoutConstraint
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightLayoutConstraint;           ///< heightLayoutConstraint
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelBottonLayoutConstraint; ///< BottonLayoutConstraint
@property (weak, nonatomic) IBOutlet UIView *scanfAreaView; ///< scanfAreaView

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray <UIView *> *backgroundViewArray;    ///< backgroundViewArray
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray <UIImageView *>*feetViewArray; ///< feetViewArray

@property (weak, nonatomic) IBOutlet UIImageView *feetImageView1; ///< feetImageView1
@property (weak, nonatomic) IBOutlet UIImageView *feetImageView2; ///< feetImageView2
@property (weak, nonatomic) IBOutlet UIImageView *feetImageView3; ///< feetImageView3
@property (weak, nonatomic) IBOutlet UIImageView *feetImageView4; ///< feetImageView4
@property (weak, nonatomic) IBOutlet UIImageView *scanfLinView;   ///< scanfLinView
@property (weak, nonatomic) IBOutlet UILabel *scanTitleLabel;     ///< scanTitleLabel
@property (weak, nonatomic) IBOutlet UIView *areaView;            ///< areaView
@property (weak, nonatomic) IBOutlet UIButton *openLightButton;   ///< openLightButton
@property (copy, nonatomic) dispatch_block_t openLightBlock;      ///< openLightBlock
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

/**
 创建 扫描UI
 */
+ (instancetype)defaultUIView;

- (void)startAnimation; ///< 开始动画
- (void)stopAnimation; ///< 结束动画

@end
