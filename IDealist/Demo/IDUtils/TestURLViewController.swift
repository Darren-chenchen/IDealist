//
//  TestURLViewController.swift
//  Ideal-IOS
//
//  Created by darren on 2018/12/5.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit
   

class TestURLViewController: IDBaseViewController {

    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label1: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.id_navTitle = "URL特殊字符处理"
        
        self.label2.text = URL.id_init(string: self.label1.text!)?.absoluteString
    }

}
