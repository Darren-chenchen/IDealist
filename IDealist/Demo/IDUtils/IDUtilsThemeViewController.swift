//
//  IDUtilsThemeViewController.swift
//  IdealDemo
//
//  Created by darren on 2018/12/4.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit

class IDUtilsThemeViewController: IDBaseViewController {
    
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.id_navTitle = "更换主题"
    }

    @IBAction func clickDefault(_ sender: Any) {
        
            IDealistConfig.share.id_setupMainColor(color: UIColor.init(redValue: 13, green: 13, blue: 255, alpha: 1))
        
        IDDialog.id_show(msg: "设置成功", leftActionTitle: nil, rightActionTitle: "确定", leftHandler: nil, rightHandler: nil)
    }
    @IBAction func clickCustom1(_ sender: Any) {
        
            IDealistConfig.share.id_setupMainColor(color: UIColor.init(redValue: 115, green: 109, blue: 216, alpha: 1))
        IDDialog.id_show(msg: "设置成功", leftActionTitle: nil, rightActionTitle: "确定", leftHandler: nil, rightHandler: nil)

    }
    @IBAction func clickCustom2(_ sender: Any) {
            IDealistConfig.share.id_setupMainColor(color: UIColor.red)
        IDDialog.id_show(msg: "设置成功", leftActionTitle: nil, rightActionTitle: "确定", leftHandler: nil, rightHandler: nil)
    }
}
