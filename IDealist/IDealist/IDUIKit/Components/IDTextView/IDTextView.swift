//
//  IDTextView.swift
//  IDUIKit-ios
//
//  Created by darren on 2018/11/30.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit

public typealias IDTextViewTextDidChangedClouse = (CGFloat) -> ()

public class IDTextView: UITextView {
    public var id_placehoder: String? {
        didSet{
            // 设置文字
            self.placehoderLabel?.text = id_placehoder
            // 重新计算子控件的fame
            self.setNeedsLayout()
        }
    }
    public var id_placehoderColor: UIColor? {
        didSet{
            // 设置颜色
            self.placehoderLabel?.textColor = id_placehoderColor
        }
    }
    var placehoderLabel: UILabel?
    
    public var textChangeClouse: IDTextViewTextDidChangedClouse?

    /// 最多允许输入多少个字符
    public var id_maxLength: Int?
    /// 只允许输入数字和小数点
    public var id_onlyNumberAndPoint: Bool?
    /// 设置小数点位数
    public var id_pointLength: Int?
    /// 只允许输入数字
    public var id_onlyNumber: Bool?
    /// 禁止输入表情符号emoji
    public var id_allowEmoji: Bool?
    /// 正则表达式
    public var id_predicateString: String?
    // 是否支持文本高度跟随内容变化而变化
    public var id_supportAutoHeight = false
    
    // 记录textview的临时值
    var tempText: String?
    
    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        self.setupTexiView()
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupTexiView()
    }
    
    func setupTexiView(){
        self.backgroundColor = UIColor.clear
        
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 5
        
        // 添加一个显示提醒文字的label（显示占位文字的label）
        let placehoderLabel = UILabel()
        placehoderLabel.numberOfLines = 0
        placehoderLabel.backgroundColor = UIColor.clear
        self.addSubview(placehoderLabel)
        self.placehoderLabel = placehoderLabel
        
        // 设置默认的占位文字颜色
        self.id_placehoderColor = UIColor.lightGray
        
        // 设置默认的字体
        self.font = UIFont.systemFont(ofSize: 14)
        
        NotificationCenter.default.addObserver(self, selector: #selector(IDTextView.textDidChange), name: UITextView.textDidChangeNotification, object: self)
    }
    //MARK - 监听文字改变
    @objc func textDidChange(){
        // 只允许输入数字和小数点
        if self.id_onlyNumberAndPoint == true {
            self.dealOnlyNumberAndPoint()
        }
        
        // 限制长度
        if self.id_maxLength != nil && self.id_maxLength! > 0 {
            if (self.text.count) > (self.id_maxLength)! {
                let subString = self.text.id_subString(to: (self.id_maxLength)!)
                self.text = subString
            }
        }
        
        // 数字
        if self.id_onlyNumber == true {
            for i in (self.text)! {
                if "0123456789".contains(i)==false {
                    let index = self.text.index(of: i)
                    if index != nil {
                        self.text.remove(at: index!)
                    }
                }
            }
        }
        
        // 表情符号
        if self.id_allowEmoji == false {
            for i in (self.text)! {
                let resultStr = String.init(i)
                if (resultStr as NSString).length > 1 { // 表情的长度是2，字符个数是1，可以过滤表情
                    let index = self.text.index(of: i)
                    if index != nil {
                        self.text.remove(at: index!)
                    }
                }
            }
        }
        
        // 自定义正则
        if self.id_predicateString != nil {
            self.dealPredicate()
        }
        
        self.tempText = self.text
        
        self.placehoderLabel?.isHidden = (self.text.count != 0)
        let constraintSize = CGSize(
            width: self.frame.width - 10,
            height: CGFloat.greatestFiniteMagnitude
        )
        let msgSize = self.sizeThatFits(constraintSize)
        // 文字frame
        if msgSize.height > self.frame.size.height {
            if id_supportAutoHeight {
                self.frame.size.height = msgSize.height
            }
        }
        if self.textChangeClouse != nil {
            self.textChangeClouse!(msgSize.height)
        }
    }
    
    func dealPredicate() {
        if (self.tempText?.count ?? 0) > self.text.count {  // 回退的时候可能会出现tempText为1234，textview=123的情况
            self.tempText = self.text
        }
        // 用户输入的，比如textview=123 用户再输入4，那么newInputStr = 4
        var newInputStr = self.text.id_subString(from: self.tempText?.count ?? 0)
        
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", (self.id_predicateString ?? ""))
        let isRight = predicate.evaluate(with: newInputStr)
        if !isRight {
            newInputStr = ""
        }
        self.text = (self.tempText ?? "") + newInputStr
    }
    
    func dealOnlyNumberAndPoint() {
        if (self.tempText?.count ?? 0) > self.text.count {  // 回退的时候可能会出现tempText为1234，textview=123的情况
            self.tempText = self.text
        }
        // 用户输入的，比如textview=123 用户再输入4，那么newInputStr = 4
        var newInputStr = self.text.id_subString(from: self.tempText?.count ?? 0)
        
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
        if self.id_pointLength != nil && self.id_pointLength! > 0 {
            let arr = self.tempText?.components(separatedBy: ".")
            if arr?.count == 2 { // 有小数点
                // 小数点位数
                let pointConut = arr?.last?.count ?? 0
                if pointConut >= self.id_pointLength! {
                    self.tempText = (arr?.first ?? "") + "." + (arr?.last?.id_subString(to: self.id_pointLength!) ?? "")
                    newInputStr = ""
                } else {
                    let count = (arr?.last?.count ?? 0) + newInputStr.count
                    if count > self.id_pointLength! {
                        let newCount = count - self.id_pointLength!
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
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        var oldFrame = self.placehoderLabel?.frame
        oldFrame?.origin.y = 8
        oldFrame?.origin.x = 5
        //类似a = 1 - a这种运算，需要先将a提取出来，否则会报错
        let flag = 2 * (oldFrame?.origin.x)!
        oldFrame?.size.width = self.frame.size.width - flag
        
        // 根据文字计算label的高度
        let constraintSize = CGSize(
            width: (self.placehoderLabel?.frame.size.width)! - 40,
            height: CGFloat.greatestFiniteMagnitude
        )
        let placehoderSize = self.placehoderLabel?.sizeThatFits(constraintSize)
        
        if placehoderSize != nil {
            oldFrame?.size.height = (placehoderSize?.height)!
            self.placehoderLabel?.frame = oldFrame!
        }
        self.placehoderLabel?.isHidden = (self.text.count != 0)
    }
}


