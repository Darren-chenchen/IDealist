//
//  TestSwitchViewController.swift
//  IDUIKit-ios
//
//  Created by darren on 2018/12/3.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit
   
    
class TestSwitchViewController: IDBaseViewController {

    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    
    /// IDSwitch 默认宽80高40
    lazy var mySwitch: IDSwitch = {
        let s = IDSwitch.init()
        s.frame.origin.y = 2
        s.frame.origin.x = KScreenWidth-90
        s.isOn = false
        return s
    }()
    lazy var mySwitch2: IDSwitch = {
        let s = IDSwitch.init()
        s.frame.origin.y = 2
        s.frame.origin.x = KScreenWidth-90
        s.isOn = true
        return s
    }()
    lazy var mySwitch3: IDSwitch = {
        let s = IDSwitch.init()
        s.frame.origin.y = 2
        s.frame.origin.x = KScreenWidth-90
        s.id_Enable = false
        return s
    }()
    lazy var mySwitch4: IDSwitch = {
        let s = IDSwitch.init()
        s.frame.origin.y = 2
        s.frame.origin.x = KScreenWidth-90
        s.id_mainColor = UIColor.red
        return s
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.id_navTitle = "IDSwitch"

        self.view.backgroundColor = UIColor.groupTableViewBackground
        self.view1.addSubview(self.mySwitch)
        self.view2.addSubview(self.mySwitch2)
        self.view3.addSubview(self.mySwitch3)
        self.view4.addSubview(self.mySwitch4)

        self.mySwitch.valueChange = {(value) in
            print(value)
        }
    }

}
