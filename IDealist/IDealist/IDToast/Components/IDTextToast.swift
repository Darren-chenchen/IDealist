//
//  TextToast.swift
//  ideal
//
//  Created by darren on 2018/8/21.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit

class IDTextToast: UIView {
        
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    
    open var text: String? {
        get { return self.titleLabel.text }
        set { self.titleLabel.text = newValue }
    }
    
    var position = IDToastPosition.middle
    
    var keyBoardHeight: CGFloat = 0
    
    var superWidth = KScreenWidth
    var superHeight = KScreenHeight

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.titleLabel)
        
        initEventHendle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initEventHendle() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(aNotification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(aNotification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        ScreenTools.share.screenClouse = { [weak self] (orientation) in
            self?.setNeedsLayout()
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    @objc func keyboardWillShow(aNotification: Notification) {
        let userInfo = aNotification.userInfo
        guard let info = userInfo else {
            return
        }
        let aValue = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        let keyboardRect = aValue?.cgRectValue
        let height = keyboardRect?.size.height
        self.keyBoardHeight = height ?? 0
        self.setNeedsLayout()
    }
    @objc func keyboardWillHide(aNotification: Notification) {
        self.keyBoardHeight = 0
        self.setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.superWidth = self.superview?.frame.size.width ?? KScreenWidth
        self.superHeight = self.superview?.frame.size.height ?? KScreenHeight

        let constraintSize = CGSize(
            width: superWidth - 40,
            height: CGFloat.greatestFiniteMagnitude
        )
        let textLabelSize = self.titleLabel.sizeThatFits(constraintSize)
        self.titleLabel.preferredMaxLayoutWidth = superWidth - 40
        
        
        var Y = self.superHeight*0.5
        if self.position == .middle {
            Y = self.superHeight*0.5 - textLabelSize.height*0.5
            if self.keyBoardHeight > 0 {
                Y = self.superHeight - self.keyBoardHeight - textLabelSize.height - 30
            }
        }
        if self.position == .top {
            Y = 100
        }
        if self.position == .bottom {
            Y = self.superHeight - 100 - textLabelSize.height
            if self.keyBoardHeight > 0 {
               Y = self.superHeight - self.keyBoardHeight - textLabelSize.height - 30
            }
        }
        self.frame = CGRect.init(x: 0.5*(superWidth-textLabelSize.width-30), y: Y, width: textLabelSize.width + 30, height: textLabelSize.height + 30)
        self.titleLabel.frame = CGRect.init(x: 15, y: 15, width: textLabelSize.width, height:  textLabelSize.height)
    }
}
