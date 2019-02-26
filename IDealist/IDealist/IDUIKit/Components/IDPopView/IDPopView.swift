//
//  IDPopView.swift
//  IDUIKit-ios
//
//  Created by darren on 2018/11/30.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit

extension UIImage {

    static func my_resizableImage(name: String) -> UIImage {
        let normal = UIImage(named: name)
        let w = (normal?.size.width ?? 0) * 0.5
        let h = (normal?.size.height ?? 0) * 0.5
        return normal?.resizableImage(withCapInsets: UIEdgeInsets.init(top: h, left: w, bottom: h, right: w)) ?? UIImage()
    }
}

public enum IDPopViewArrowPosition {
    case left
    case center
    case right
    case custom  // 自定义
}

public typealias PopMenuDidDismissedClouse = () ->()

public class IDPopView: UIView {
    
    public var popMenuDidDismissed: PopMenuDidDismissedClouse?
    
    var contentView: UIView?
    var container: UIImageView?
    
    // 背景色
    public var id_bgColor = UIColor.white {
        didSet {
            self.container?.backgroundColor = id_bgColor
        }
    }
    // 边框颜色
    public var id_borderColor = UIColor.clear
    // 边框大小
    public var id_borderWidth = 1
    // 三角形的大小
    public var id_triangleSize = CGSize.init(width: 8, height: 8)
    // 三角形位置
    public var id_trianglePoint = CGPoint.zero
    public var id_arrowPosition: IDPopViewArrowPosition = .right
    
    // 内容背景
    public var id_backgroundImg: UIImage? {
        didSet {
            self.container?.image = id_backgroundImg
        }
    }

    init(frame: CGRect, contentView: UIView? = nil) {
        super.init(frame: frame)
        
        self.contentView = contentView
    
        self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action:  #selector(clickCover)))
        
        self.container = UIImageView.init()
        self.container?.isUserInteractionEnabled = true
        self.container?.backgroundColor = self.id_bgColor
        self.addSubview(self.container!)
        self.container?.layer.cornerRadius = 5

        self.backgroundColor = UIColor(white: 0, alpha: 0.3)
        self.alpha = 0
    }
    
    public static func `init`(contentView: UIView) -> IDPopView {
        let pop = IDPopView.init(frame: CGRect.zero, contentView: contentView)
        return pop
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func clickCover() {
        self.dismiss()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func dismiss() {
        
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
        }) { (finish) in
            if self.popMenuDidDismissed != nil {
                self.popMenuDidDismissed!()
            }
            self.removeFromSuperview()
        }
    }
    
    /// rect容器的尺寸，内容的尺寸x=5,y=8
    public func showInRect(rect: CGRect) {
        
        let h = self.id_triangleSize.height
        
        if id_arrowPosition == .left {
            self.id_trianglePoint = CGPoint.init(x: rect.origin.x + 40, y: rect.origin.y-h)
        }
        if id_arrowPosition == .right {
            self.id_trianglePoint = CGPoint.init(x: rect.origin.x + rect.width - 40, y: rect.origin.y-h)
        }
        if id_arrowPosition == .center {
            self.id_trianglePoint = CGPoint.init(x: rect.origin.x + (rect.width*0.5), y: rect.origin.y-h)
        }
        
        self.animationShow()
        
        self.container?.frame = rect
        self.container?.addSubview(self.contentView ?? UIView())
        
        let topMargin: CGFloat = 8
        let leftMargin: CGFloat = 5
        let rightMargin: CGFloat = 5
        let bottomMargin: CGFloat = 8
    
        self.contentView?.frame.origin.y = topMargin
        self.contentView?.frame.origin.x = leftMargin
        self.contentView?.frame.size.width = (self.container?.frame.width ?? 0) - leftMargin - rightMargin
        self.contentView?.frame.size.height = (self.container?.frame.height ?? 0) - topMargin - bottomMargin
        
        self.layoutIfNeeded()
    }
    
    func animationShow() {
        let window = UIApplication.shared.keyWindow
        self.frame = window?.bounds ?? CGRect.zero
        window?.addSubview(self)
        // 设置右上角为transform的起点（默认是中心点）
        self.container?.layer.position = CGPoint.init(x: self.id_trianglePoint.x, y: self.id_trianglePoint.y)
        // 向右下transform
        if id_arrowPosition == .right {
            self.container?.layer.anchorPoint = CGPoint(x:1, y:0)
        }
        if id_arrowPosition == .left {
            self.container?.layer.anchorPoint = CGPoint(x:0.5, y:0)
        }
        if id_arrowPosition == .center {
            self.container?.layer.anchorPoint = CGPoint(x:0.5, y:0)
        }
        if id_arrowPosition == .custom {
            self.container?.layer.anchorPoint = CGPoint(x:0.5, y:0)
        }
        
        self.container?.transform = CGAffineTransform.init(scaleX: 0.0001, y: 0.0001)
        
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1
            self.container?.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        }
    }
    
    public override func draw(_ rect: CGRect) {
        
        let w = self.id_triangleSize.width
        let h = self.id_triangleSize.height
        
        self.id_bgColor.set()
        let context = UIGraphicsGetCurrentContext()
        context!.beginPath()
        context?.move(to: CGPoint.init(x: id_trianglePoint.x, y: id_trianglePoint.y))
        
        context?.addLine(to: CGPoint.init(x: id_trianglePoint.x-w, y: id_trianglePoint.y+h))
        context?.addLine(to: CGPoint.init(x: id_trianglePoint.x+w, y: id_trianglePoint.y+h))
        
        context?.closePath()
        
        self.id_bgColor.setFill() // 设置填充色
        self.id_borderColor.setStroke() // 设置边框颜色
        context?.drawPath(using: CGPathDrawingMode.fillStroke)
    }
}
