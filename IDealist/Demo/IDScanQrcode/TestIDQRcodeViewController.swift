//
//  TestIDQRcodeViewController.swift
//  IdealDemo
//
//  Created by darren on 2018/12/8.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit

class TestIDQRcodeViewController: IDScanCodeController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.customNavBar.backgroundColor = UIColor.white
        self.customNavBar.titleLable.textColor = UIColor.black
        self.rightBtn.setTitleColor(UIColor.black, for: .normal)
        self.backBtn.setImage(UIImage(named: "ic_back_grey"), for: .normal)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

}
