//
//  IDImageView.swift
//  IDUIKit-ios
//
//  Created by darren on 2018/12/4.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit

public extension UIImage{

    /// 通过颜色生成图片
    public class func id_renderImageWithColor(_ color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return UIImage()
        }
        context.setFillColor(color.cgColor);
        context.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height));
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img ?? UIImage()
    }
}
