//
//  HDToastUtil.swift
//  Ideal
//
//  Created by darren on 2018/8/23.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit

public enum IDToastUtilsImageType {
    case success
    case fail
    case warning
}
class IDToastUtils: Operation {

    private var _executing = false
    override open var isExecuting: Bool {
        get {
            return self._executing
        }
        set {
            self.willChangeValue(forKey: "isExecuting")
            self._executing = newValue
            self.didChangeValue(forKey: "isExecuting")
        }
    }
    
    private var _finished = false
    override open var isFinished: Bool {
        get {
            return self._finished
        }
        set {
            self.willChangeValue(forKey: "isFinished")
            self._finished = newValue
            self.didChangeValue(forKey: "isFinished")
        }
    }
    
    var textToastView: IDTextToast = IDTextToast()   // 纯文本
    var imageToastView: IDImageToast = IDImageToast()  // 含有图片
    
    var textMessage: String? {
        get { return self.textToastView.text }
        set { self.textToastView.text = newValue }
    }
    
    var imgMessage: String? {
        get { return self.imageToastView.text }
        set { self.imageToastView.text = newValue }
    }
    
    // 动画起始值
    var animationFromValue: CGFloat = 0
    var superComponent: UIView = UIView()
    var showSuccessToast: IDToastUtilsImageType?
    var duration: CGFloat = 1.5  // 默认展示2秒
    var position = IDToastPosition.middle

    init(msg: String,onView:UIView? = nil,success: IDToastUtilsImageType? = nil,duration:CGFloat? = nil, position: IDToastPosition? = .middle) {
        
        self.superComponent = onView ?? (UIApplication.shared.keyWindow ?? UIView())
        self.showSuccessToast = success
        self.duration = duration ?? 1.5
        self.position = position ?? IDToastPosition.middle
        
        super.init()
        
        if self.showSuccessToast == nil {
            self.textMessage = msg
            self.textToastView.position = self.position
        } else {
            self.imgMessage = msg
            self.imageToastView.position = self.position
        }

        // 单利队列中每次都加入一个新建的Operation
        IDToastManager.share.add(self)
    }
    
    open override func cancel() {
        super.cancel()
        self.dismiss()
    }
    override func start() {
        let isRunnable = !self.isFinished && !self.isCancelled && !self.isExecuting
        guard isRunnable else { return }
        guard Thread.isMainThread else {
            DispatchQueue.main.async { [weak self] in
                self?.start()
            }
            return
        }
        main()
    }
    override func main() {
        self.isExecuting = true
        
        DispatchQueue.main.async {
            if self.showSuccessToast == nil {
                self.textToastView.titleLabel.textColor = IDToastManager.share.textColor
                self.textToastView.titleLabel.font = IDToastManager.share.textFont
                self.textToastView.backgroundColor = IDToastManager.share.bgColor
                self.textToastView.layer.cornerRadius = IDToastManager.share.cornerRadius

                self.textToastView.setNeedsLayout()
                self.superComponent.addSubview(self.textToastView)
            } else {
                self.imageToastView.titleLabel.textColor = IDToastManager.share.textColor
                self.imageToastView.titleLabel.font = IDToastManager.share.textFont
                self.imageToastView.backgroundColor = IDToastManager.share.bgColor
                self.imageToastView.layer.cornerRadius = IDToastManager.share.cornerRadius
                
                self.imageToastView.setNeedsLayout()
                self.superComponent.addSubview(self.imageToastView)
                if self.showSuccessToast == .success {
                    self.imageToastView.iconView.image = IDToastManager.share.successImage
                }
                if self.showSuccessToast == .fail {
                    self.imageToastView.iconView.image = IDToastManager.share.failImage
                }
                if self.showSuccessToast == .warning {
                    self.imageToastView.iconView.image = IDToastManager.share.warnImage
                }
            }
            
            let shakeAnimation = CABasicAnimation.init(keyPath: "opacity")
            shakeAnimation.duration = 0.5
            shakeAnimation.fromValue = self.animationFromValue
            shakeAnimation.toValue = 1
            shakeAnimation.delegate = self
            
            if self.showSuccessToast == nil {
                self.textToastView.layer.add(shakeAnimation, forKey: nil)
            } else {
                self.imageToastView.layer.add(shakeAnimation, forKey: nil)
            }
        }
    }
}

extension IDToastUtils: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            UIView.animate(withDuration: 0.5, delay: TimeInterval(self.duration), options: UIView.AnimationOptions.allowUserInteraction, animations: {
                if self.showSuccessToast == nil {
                    self.textToastView.alpha = 0
                } else {
                    self.imageToastView.alpha = 0
                }
            }) { (finish) in
                self.dismiss()
            }
        }
    }
    
    func dismiss() {
        self.textToastView.removeFromSuperview()
        self.imageToastView.removeFromSuperview()
        self.finish()
    }
    
    func finish() {
        self.isExecuting = false
        self.isFinished = true
        
        if IDToastManager.share.supportQuene == false {
            IDToastManager.share.cancelAll()
        }
    }
}
