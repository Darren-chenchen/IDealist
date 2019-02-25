//
//  TestStringViewController.swift
//  Ideal-IOS
//
//  Created by darren on 2018/12/5.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit

class TestStringViewController: IDBaseViewController {

    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label1: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.id_navTitle = "字符串处理"

        self.label2.text = self.label1.text?.id_subString(to: 5)
        
        self.label4.text = self.label3.text?.id_subString(from: 5)
        
        self.label6.text = self.label5.text?.id_subString(from: 5, offSet: 2)
    }

}
