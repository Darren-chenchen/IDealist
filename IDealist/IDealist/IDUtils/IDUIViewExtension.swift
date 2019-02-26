//
//  UIViewUtils.swift
//  Ideal-IOS
//
//  Created by darren on 2018/12/4.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit
public enum UIViewGradientDirection {
    case horizontally
    case vertically
}

public extension UIView {
    /// x
    public var id_x: CGFloat {
        get {
            return frame.origin.x
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x    = newValue
            frame                 = tempFrame
        }
    }
    
    /// y
    public var id_y: CGFloat {
        get {
            return frame.origin.y
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y    = newValue
            frame                 = tempFrame
        }
    }
    
    /// height
    public var id_height: CGFloat {
        get {
            return frame.size.height
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.height = newValue
            frame                 = tempFrame
        }
    }
    
    /// width
    public var id_width: CGFloat {
        get {
            return frame.size.width
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
    }
    
    /// size
    public var id_size: CGSize {
        get {
            return frame.size
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size = newValue
            frame = tempFrame
        }
    }
    
    /// centerX
    public var id_centerX: CGFloat {
        get {
            return center.x
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }
    
    /// centerY
    public var id_centerY: CGFloat {
        get {
            return center.y
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y = newValue
            center = tempCenter;
        }
    }
    
    public func id_addGradientLayer(gradientColors: [UIColor],gradientDirection direction: UIViewGradientDirection, gradientFrame: CGRect? = nil) {
        
        //创建并实例化CAGradientLayer
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        //设置frame和插入view的layer
        if let gradientFrame = gradientFrame {
            gradientLayer.frame = gradientFrame
        }else {
            gradientLayer.frame = CGRect(x: 0, y: 0, width: id_width, height: id_height)
        }
        
        gradientLayer.colors = gradientColors.map({ (color) -> CGColor in
            
            return color.cgColor
        })
        //(这里的起始和终止位置就是按照坐标系,四个角分别是左上(0,0),左下(0,1),右上(1,0),右下(1,1))
        if direction == .horizontally {
            
            gradientLayer.startPoint = CGPoint.init(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint.init(x: 1, y: 0.5)
        }else {
            
            gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint.init(x: 0, y: 1)
        }
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    /// 设置圆角
    @discardableResult
    public func id_border(_ borderWidth: CGFloat?, _ borderColor:UIColor?=nil, _ cornerRadius:CGFloat?) -> UIView{
        self.layer.borderWidth = borderWidth ?? 0
        self.layer.borderColor = borderColor?.cgColor
        self.layer.cornerRadius = cornerRadius ?? 0
        self.layer.masksToBounds = true
        return self
    }
    
    /// 设置指定部位的圆角
    @discardableResult
    public func id_borderSpecified(_ specified: UIRectCorner,cornerRadius:CGFloat) -> UIView {
        let maskPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: specified, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        return self
    }
}
