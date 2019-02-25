//
//  IDLabel.swift
//  IDUIKit-ios
//
//  Created by darren on 2018/11/30.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
// 支持复制，支持图文混排

import UIKit

var IDLabelCopyKey = 101

public extension IDLabel {
    public var id_canCopy: Bool {
        set {
            objc_setAssociatedObject(self, &IDLabelCopyKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
            self.layoutSubviews()
        }
        get {
            if let rs = objc_getAssociatedObject(self, &IDLabelCopyKey) as? Bool {
                return rs
            }
            return false
        }
    }
}

public class IDLabel: UILabel {
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.common()
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.common()
    }
    public required init?(coder aDecoder: NSCoder) {
        //实现父类的该方法
        super.init(coder: aDecoder)
        
        self.common()
    }
    func common() {
    }
    public func id_setupAttbutImage(img: UIImage, index: Int, _ imageFrame: CGRect =  CGRect(x: 0, y: -4, width: 20, height: 20)) {
        var flagIndex = index
        guard let str = self.text else {
            return
        }
        if flagIndex > str.count {
            flagIndex = str.count
        }
        // 根据index,将string分成2部分
        let startIndex = str.startIndex
        let str1 = str.index(startIndex, offsetBy: flagIndex)
        let begin = String(str[startIndex..<str1])
        let end = String(str[str1...])
       
        let attributedText = NSMutableAttributedString()
        
        // 开始
        let beginStr = NSAttributedString(string: begin)
        attributedText.append(beginStr)
        
        // 图片
        let attach = NSTextAttachment()
        attach.image = img
        attach.bounds = imageFrame
        let emotionStr = NSAttributedString(attachment: attach)
        attributedText.append(emotionStr)

        // 尾部
        let endStr = NSAttributedString(string: end)
        attributedText.append(endStr)

        self.attributedText = attributedText
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.id_canCopy {
            self.addLongPressHandler()
        }
    }
    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(self.copy(_:)) {
            return true
        }else{
            return false
        }
    }
    public override func copy(_ sender: Any?) {
        let pBoard = UIPasteboard.general
        pBoard.string = self.text
    }

    public override var canBecomeFirstResponder: Bool {
        return true
    }
    
    // MARK: - private method
    func addLongPressHandler() {
        //UILabel默认不接收事件，添加touch事件
        self.isUserInteractionEnabled = true
        let longPressGesture = UILongPressGestureRecognizer.init(target: self, action: #selector(longPressAction))
        self.addGestureRecognizer(longPressGesture)
    }
    @objc func longPressAction() {
        self.becomeFirstResponder()
        let copyItem = UIMenuItem(title: "复制", action: #selector(self.copy(_:)))
        let menu = UIMenuController.shared
        menu.menuItems = [copyItem]
        if menu.isMenuVisible {
            return
        }
        menu.setTargetRect(bounds, in: self)
        menu.setMenuVisible(true, animated: true)
    }
}
