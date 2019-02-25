//
//  TestIDViewViewController.swift
//  Ideal-IOS
//
//  Created by darren on 2018/12/5.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit
   

class TestIDViewViewController: IDBaseViewController {

    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var VIEW2: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var testView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.id_navTitle = "UIView属性扩展"
        
        self.testView.id_addGradientLayer(gradientColors: [UIColor.red, UIColor.blue], gradientDirection: UIViewGradientDirection.horizontally)
        
        self.view1.id_border(1,UIColor.red, 5)
        self.VIEW2.id_borderSpecified(UIRectCorner.topLeft, cornerRadius: 6)
        self.view3.id_borderSpecified(UIRectCorner.topRight, cornerRadius: 6)
    }
}
