//
//  BundleTools.m
//  IDScanCode
//
//  Created by darren on 2018/12/22.
//  Copyright © 2018年 haiding.123.com. All rights reserved.
//

#import "BundleTools.h"
@implementation BundleTools
+ (NSBundle*)getCurrentBundle {
    NSBundle *podBundle = [NSBundle bundleForClass: self.class];
    NSURL *bundleURL = [podBundle URLForResource: @"IDealist" withExtension: @"bundle"];
    NSBundle *bundle = NSBundle.mainBundle;
    if (bundleURL != nil) {
        bundle = [NSBundle bundleWithURL:bundleURL];
    }
    return bundle;
}
@end
