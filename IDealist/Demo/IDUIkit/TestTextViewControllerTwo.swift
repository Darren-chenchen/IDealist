//
//  TestTextViewControllerTwo.swift
//  IdealDemo
//
//  Created by darren on 2018/12/26.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit
    

class TestTextViewControllerTwo: IDBaseViewController {
    lazy var textView2: IDTextView = {
        let text = IDTextView.init(frame: CGRect.init(x: 10, y: 150, width: KScreenWidth-20, height: 80))
        text.id_placehoder = "我是代码创建的"
        return text
    }()
    
    lazy var textView3: IDTextView = {
        let text = IDTextView.init(frame: CGRect.init(x: 10, y: 300, width: KScreenWidth-20, height: 50))
        text.id_placehoder = "支持高度自动增加"
        text.id_supportAutoHeight = true
        return text
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.id_navTitle = "IDTextView"
        self.view.backgroundColor = UIColor.groupTableViewBackground
        
        
        self.view.addSubview(self.textView2)
        self.view.addSubview(self.textView3)
        
    }

}
