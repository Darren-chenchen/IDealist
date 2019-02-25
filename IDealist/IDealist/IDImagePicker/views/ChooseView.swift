//
//  ChooseView.swift
//  IDImagePicker-IOS
//
//  Created by darren on 2018/12/5.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit

typealias ChooseViewClickClouse = () -> ()

class ChooseView: UIView {

    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var chooseBottomView: UIView!
    @IBOutlet weak var iconView: UIImageView!
    
    static func show() -> ChooseView {
        return BundleUtil.getCurrentBundle().loadNibNamed("ChooseView", owner: nil, options: nil)?.last as! ChooseView
    }
    
    var chooseClouse: ChooseViewClickClouse?
    
    // 选择和非选择的切换
    var isSelect: Bool = false {
        didSet {
            if isSelect {
                self.chooseBottomView.isHidden = true
                
                self.iconView.tintColor = CLPickersTools.instence.tineColor
                let img = UIImage.init(named: "icn_finish", in: BundleUtil.getCurrentBundle(), compatibleWith: nil)?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                self.iconView.image = img
                self.iconView.backgroundColor = UIColor.white
                CLViewsBorder(self.iconView, borderWidth: 0, cornerRadius: 11)
            } else {
                self.chooseBottomView.isHidden = true
                
                let img = UIImage.init(named: "icn_icn_choose", in: BundleUtil.getCurrentBundle(), compatibleWith: nil)
                self.iconView.image = img
                self.iconView.backgroundColor = UIColor.clear
            }
        }
    }
    /// num 和 e非选择的切换
    var num: Int? {
        didSet {
            if num == nil {
                self.chooseBottomView.isHidden = true
                self.iconView.image = UIImage.init(named: "icn_icn_choose", in: BundleUtil.getCurrentBundle(), compatibleWith: nil)
            } else {
                self.chooseBottomView.isHidden = false
                self.numLabel.text = "\(num!)"
            }
        }
    }
    
    func common() {
        self.backgroundColor = UIColor.clear
        self.autoresizingMask = .init(rawValue: 0)
        self.chooseBottomView.isHidden = true
        
        CLViewsBorder(self.chooseBottomView, borderWidth: 0, borderColor: UIColor.white, cornerRadius: 11)

        self.numLabel.isUserInteractionEnabled = false
        self.chooseBottomView.isUserInteractionEnabled = false
        self.chooseBottomView.backgroundColor = CLPickersTools.instence.tineColor
        
        self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(clickView)))
    }
    
    @objc func clickView() {
        if self.chooseClouse != nil {
            self.chooseClouse!()
        }
        
        // 动画
        let shakeAnimation = CABasicAnimation.init(keyPath: "transform.scale")
        shakeAnimation.duration = 0.1
        shakeAnimation.fromValue = 0.8
        shakeAnimation.toValue = 1
        shakeAnimation.autoreverses = true
        self.layer.add(shakeAnimation, forKey: nil)
    }
}
