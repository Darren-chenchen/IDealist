//
//  IDSwitch.swift
//  IDUIKit-ios
//
//  Created by darren on 2018/12/3.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit
public typealias IDSwitchValueChangeClouse  = (_ value: Bool) -> Void

public class IDSwitch: UIControl {

    public var valueChange : IDSwitchValueChangeClouse?
    public var id_animateDuration : Double = 0.3
    
    public var id_lineWidth : CGFloat = 1
    
    public var id_mainColor : UIColor = (IDealistConfig.share.mainColor) {
        didSet {
            setUpView()
        }
    }
    public var id_offColor : UIColor = UIColor(white: 0.9, alpha: 1) {
        didSet {
            setUpView()
        }
    }
    public var id_lineColor : UIColor = UIColor(white: 0.8, alpha: 1) {
        didSet {
            setUpView()
        }
    }
    public var id_circleColor : UIColor = UIColor.white {
        didSet {
            setUpView()
        }
    }
    public var isOn : Bool {
        set {
            on = newValue
            setUpView()
        }
        get {
            return on
        }
    }
    var on : Bool = true
    
    public var id_Enable: Bool = true {
        didSet {
            if id_Enable {
                self.isEnabled = true
                self.alpha = 1
            } else {
                self.isEnabled = false
                self.alpha = 0.5
            }
        }
    }
    
    private var swichControl = CAShapeLayer()
    private var backgroundLayer = CAShapeLayer()
    
    // MARK: - Init
    convenience public init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    
    internal func setUpView(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(IDSwitch.changeValue))
        self.addGestureRecognizer(tap)
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        self.backgroundColor = UIColor.clear
        let frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        let radius = bounds.height/2 - id_lineWidth
        let roundedRectPath = UIBezierPath(roundedRect:frame.insetBy(dx: id_lineWidth, dy: id_lineWidth) , cornerRadius:radius)
        backgroundLayer.fillColor = stateToFillColor(self.on)
        backgroundLayer.strokeColor = id_lineColor.cgColor
        backgroundLayer.lineWidth = id_lineWidth
        backgroundLayer.path = roundedRectPath.cgPath
        layer.addSublayer(backgroundLayer)
        
        let innerLineWidth =  bounds.height - id_lineWidth*3 + 1
        let swichControlPath = UIBezierPath()
        swichControlPath.move(to: CGPoint(x: id_lineWidth, y: 0))
        swichControlPath.addLine(to: CGPoint(x: bounds.width - 2 * id_lineWidth - innerLineWidth + 1, y: 0))
        var point = backgroundLayer.position
        point.y += (radius + id_lineWidth)
        point.x += (radius)
        swichControl.position = point
        swichControl.path = swichControlPath.cgPath
        swichControl.lineCap     = CAShapeLayerLineCap.round
        swichControl.fillColor   = nil
        swichControl.strokeColor = id_circleColor.cgColor
        swichControl.lineWidth   = innerLineWidth
        swichControl.strokeEnd = 0.0001
        layer.addSublayer(swichControl)
    }
    
    private func stateToFillColor(_ isOn:Bool) -> CGColor {
        return isOn ? id_mainColor.cgColor : id_offColor.cgColor
    }
    
    @objc internal func changeValue(){
        on = !on
        valueChange?(!isOn)
        sendActions(for: UIControl.Event.valueChanged)
        
        changeValueAnimate(isOn,duration: id_animateDuration)
    }
    
    // MARK: - Animate
    func changeValueAnimate(_ turnOn:Bool, duration:Double) {
        let times = [0,0.49,0.51,1]
        // 线条运动动画
        let swichControlStrokeStartAnim      = CAKeyframeAnimation(keyPath:"strokeStart")
        swichControlStrokeStartAnim.values   = turnOn ? [1,0,0, 0] : [0,0,0,1]
        swichControlStrokeStartAnim.keyTimes = times as [NSNumber]?
        swichControlStrokeStartAnim.duration = duration
        swichControlStrokeStartAnim.isRemovedOnCompletion = true
        
        let swichControlStrokeEndAnim      = CAKeyframeAnimation(keyPath:"strokeEnd")
        swichControlStrokeEndAnim.values   = turnOn ? [1,1,1,0] : [0,1,1,1]
        swichControlStrokeEndAnim.keyTimes = times as [NSNumber]?
        swichControlStrokeEndAnim.duration = duration
        swichControlStrokeEndAnim.isRemovedOnCompletion = true
        
        // 颜色动画
        let backgroundFillColorAnim      = CAKeyframeAnimation(keyPath:"fillColor")
        backgroundFillColorAnim.values   = [stateToFillColor(!turnOn),
                                            stateToFillColor(!turnOn),
                                            stateToFillColor(turnOn),
                                            stateToFillColor(turnOn)]
        backgroundFillColorAnim.keyTimes = [0,0.5,0.51,1]
        backgroundFillColorAnim.duration = duration
        backgroundFillColorAnim.fillMode = CAMediaTimingFillMode.forwards
        backgroundFillColorAnim.isRemovedOnCompletion = false
        
        // 动画组
        let swichControlChangeStateAnim : CAAnimationGroup = CAAnimationGroup()
        swichControlChangeStateAnim.animations = [swichControlStrokeStartAnim,swichControlStrokeEndAnim]
        swichControlChangeStateAnim.fillMode = CAMediaTimingFillMode.forwards
        swichControlChangeStateAnim.isRemovedOnCompletion = false
        swichControlChangeStateAnim.duration = duration
        
        let animateKey = turnOn ? "TurnOn" : "TurnOff"
        swichControl.add(swichControlChangeStateAnim, forKey: animateKey)
        backgroundLayer.add(backgroundFillColorAnim, forKey: "Color")
    }
}
