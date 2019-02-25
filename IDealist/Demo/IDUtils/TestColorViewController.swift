//
//  TestColorViewController.swift
//  Ideal-IOS
//
//  Created by darren on 2018/12/4.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit
   

class TestColorViewController: IDBaseViewController {

    @IBOutlet weak var view1: UIView!
    
    @IBOutlet weak var view2: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.id_navTitle = "颜色设置"

        self.view1.layer.cornerRadius = 40
        self.view2.layer.cornerRadius = 40

        
        self.view1.backgroundColor = UIColor.init(redValue: 13, green: 133, blue: 133, alpha: 1)
        self.view2.backgroundColor = UIColor.init(hexString: "#3423df")
    }

}
