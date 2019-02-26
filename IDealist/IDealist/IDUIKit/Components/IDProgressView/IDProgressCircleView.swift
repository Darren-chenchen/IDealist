//
//  IDProgressCircleView.swift
//  IDUIKit-ios
//
//  Created by darren on 2018/12/3.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit

public enum IDProgressCircleViewType {
    case circle
    case pie
}
public class IDProgressCircleView: UIView {

    /// value的范围是0-100
    public var id_value: CGFloat = 0 {
        didSet {
            if id_value >= 100 {
                self.id_value = 100
            }
            self.setNeedsDisplay()
        }
    }
    /// 默认是2
    public var id_lineWidth: CGFloat = 2 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    /// 颜色
    public var id_fillColor: UIColor = (IDealistConfig.share.mainColor) {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    /// 类型
    public var id_type: IDProgressCircleViewType = .circle {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var maximumValue: CGFloat = 100
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupUI()
    }
    
    func setupUI() {
        self.backgroundColor = UIColor.clear
        self.isOpaque = false
    }
    
    override public func draw(_ rect: CGRect) {
        // Drawing code
        super.draw(rect)
        if id_type == .circle {
            self.setupCircle(rect)
        } else {
            self.setupPie(rect)
        }
    }
    
    func setupCircle(_ rect: CGRect) {
        //线宽度
        let lineWidth: CGFloat = self.id_lineWidth
        //半径
        let radius: CGFloat = rect.width/2-lineWidth
        //中心点x
        let centerX = rect.midX
        //中心点y
        let centerY = rect.midY
        //弧度起点
        let startAngle = CGFloat(-90 * Double.pi / 180)
        //弧度终点
        let endAngle = CGFloat(((self.id_value / self.maximumValue) * 360.0 - 90.0) ) * CGFloat(Double.pi) / 180.0
        
        //创建一个画布
        let context = UIGraphicsGetCurrentContext()
        
        //画笔颜色
        context!.setStrokeColor(id_fillColor.cgColor)
        context?.setFillColor(id_fillColor.cgColor)
        //画笔宽度
        context!.setLineWidth(lineWidth)
        
        //（1）画布 （2）中心点x（3）中心点y（4）圆弧起点（5）圆弧结束点（6） 0顺时针 1逆时针
        context?.addArc(center: CGPoint(x:centerX,y:centerY), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        
        //绘制路径
        context!.strokePath()
    }
    
    func setupPie(_ rect: CGRect) {
        //    定义扇形中心
        let origin = CGPoint.init(x: rect.midX, y: rect.midY)
        //    定义扇形半径
        let radius = rect.width/2
        //    设定扇形起点位置
        let startAngle: CGFloat = CGFloat(-Double.pi/2)
        //    根据进度计算扇形结束位置
        let endAngle: CGFloat = startAngle + (self.id_value / self.maximumValue) * CGFloat(Double.pi * 2)
        //    根据起始点、原点、半径绘制弧线
        let sectorPath = UIBezierPath.init(arcCenter: origin, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
                //    从弧线结束为止绘制一条线段到圆心。这样系统会自动闭合图形，绘制一条从圆心到弧线起点的线段。
        sectorPath.addLine(to: origin)
        //    设置扇形的填充颜色
        id_fillColor.set()
        //    设置扇形的填充模式
        sectorPath.fill()
    }
}
