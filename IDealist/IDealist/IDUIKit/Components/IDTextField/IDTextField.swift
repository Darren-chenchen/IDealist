//
//  IDTextField.swift
//  IDUIKit-ios
//
//  Created by darren on 2018/12/3.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit

open class IDTextField: UITextField {
    /// 最多允许输入多少个字符
    open var maxLength: Int?
    /// 只允许输入数字和小数点
    open var onlyNumberAndPoint: Bool?
    /// 设置小数点位数
    open var pointLength: Int?
    /// 只允许输入数字
    open var onlyNumber: Bool?
    /// 禁止输入表情符号emoji
    open var allowEmoji: Bool?
    /// 正则表达式
    open var predicateString: String?
    
    // 记录textview的临时值
    var tempText: String?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.common()
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.common()
    }
    
    func common() {
        NotificationCenter.default.addObserver(self, selector: #selector(IDTextField.textDidChange), name: UITextField.textDidChangeNotification, object: self)
    }
    
    //MARK - 监听文字改变
    @objc func textDidChange(){
        if self.text == nil {
            return
        }
        // 只允许输入数字和小数点
        if self.onlyNumberAndPoint == true {
            self.dealOnlyNumberAndPoint()
        }
        
        // 限制长度
        if self.maxLength != nil && self.maxLength! > 0 {
            if (self.text!.count) > (self.maxLength)! {
                let subString = self.text!.id_subString(to: (self.maxLength)!)
                self.text = subString
            }
        }
        
        // 数字
        if self.onlyNumber == true {
            for i in (self.text)! {
                if "0123456789".contains(i)==false {
                    let index = self.text!.index(of: i)
                    if index != nil {
                        self.text!.remove(at: index!)
                    }
                }
            }
        }
        
        // 表情符号
        if self.allowEmoji == false {
            for i in (self.text)! {
                let resultStr = String.init(i)
                if (resultStr as NSString).length > 1 { // 表情的长度是2，字符个数是1，可以过滤表情
                    let index = self.text!.index(of: i)
                    if index != nil {
                        self.text!.remove(at: index!)
                    }
                }
            }
        }
        
        // 自定义正则
        if self.predicateString != nil {
            self.dealPredicate()
        }
        
        self.tempText = self.text
    }
    
    func dealPredicate() {
        if (self.tempText?.count ?? 0) > self.text!.count {  // 回退的时候可能会出现tempText为1234，textview=123的情况
            self.tempText = self.text
        }
        // 用户输入的，比如textview=123 用户再输入4，那么newInputStr = 4
        var newInputStr = self.text!.id_subString(from: self.tempText?.count ?? 0)
        
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", (self.predicateString ?? ""))
        let isRight = predicate.evaluate(with: newInputStr)
        if !isRight {
            newInputStr = ""
        }
        self.text = (self.tempText ?? "") + newInputStr
    }
    
    func dealOnlyNumberAndPoint() {
        if (self.tempText?.count ?? 0) > self.text!.count {  // 回退的时候可能会出现tempText为1234，textview=123的情况
            self.tempText = self.text
        }
        // 用户输入的，比如textview=123 用户再输入4，那么newInputStr = 4
        var newInputStr = self.text!.id_subString(from: self.tempText?.count ?? 0)
        
        //1.只允许输入数字和小数点
        for i in (self.tempText ?? "") {
            if "0123456789.".contains(i)==false {
                let index = self.tempText?.index(of: i)
                if index != nil {
                    self.tempText?.remove(at: index!)
                }
            }
        }
        for i in newInputStr {
            if "0123456789.".contains(i)==false {
                let index = newInputStr.index(of: i)
                if index != nil {
                    newInputStr.remove(at: index!)
                }
            }
        }
        
        // 2.限制小数点只能输入1个
        if (self.tempText?.contains(".") ?? false) {
            if newInputStr.contains(".") {
                let index = newInputStr.index(of: ".")
                if index != nil {
                    newInputStr.remove(at: index!)
                }
            }
        }
        
        // 3.限制小数点位数
        if self.pointLength != nil && self.pointLength! > 0 {
            let arr = self.tempText?.components(separatedBy: ".")
            if arr?.count == 2 { // 有小数点
                // 小数点位数
                let pointConut = arr?.last?.count ?? 0
                if pointConut >= self.pointLength! {
                    self.tempText = (arr?.first ?? "") + "." + (arr?.last?.id_subString(to: self.pointLength!) ?? "")
                    newInputStr = ""
                } else {
                    let count = (arr?.last?.count ?? 0) + newInputStr.count
                    if count > self.pointLength! {
                        let newCount = count - self.pointLength!
                        newInputStr = newInputStr.id_subString(to: newCount)
                    }
                }
            }
        }
        
        // 4.小数点不能放在第一位
        if self.tempText == nil && newInputStr == "." {
            newInputStr = ""
        }
        
        self.text = (self.tempText ?? "") + newInputStr
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
    }
}
