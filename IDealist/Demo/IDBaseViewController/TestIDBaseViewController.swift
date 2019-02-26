//
//  TestIDBaseViewController.swift
//  IdealDemo
//
//  Created by darren on 2018/12/8.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit

class TestIDBaseViewController: IDBaseViewController {

    lazy var titleLabel: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: 10, y: 90, width: 100, height: 30))
        label.text = "使用说明"
        return label
    }()
    lazy var iconView: UIImageView = {
        let img = UIImageView.init(frame: CGRect.init(x: 10, y: self.titleLabel.frame.maxY, width: KScreenWidth, height: 160))
        img.image = UIImage(named: "basevc")
        img.contentMode = .scaleAspectFit
        return img
    }()
    lazy var btn: UIButton = {
        let btn = UIButton.init(frame: CGRect.init(x: 10, y: self.iconView.frame.maxY + 40, width: KScreenWidth-20, height: 40))
        btn.setTitle("点击进入新的主页面", for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(clickBtn), for: UIControl.Event.touchUpInside)
        btn.layer.cornerRadius = 20
        btn.backgroundColor = UIColor.init(redValue: 13, green: 133, blue: 255, alpha: 1)
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.id_navTitle = "IDBaseViewController"
        
        self.view.addSubview(self.titleLabel)
        
        self.view.addSubview(self.iconView)
        self.view.addSubview(self.btn)
    }
    
    @objc func clickBtn() {
        IDealistConfig.share.id_setupMainColor(color: UIColor.red)
        
        let tabbarVC = IDTabbarViewController()
        tabbarVC.id_setupChildViewController(viewController: MainViewController(), image:  UIImage(named: "icn_nocolor_icn_components"), selectedImage: UIImage(named: "icn_color_icn_components"), title: "IDealist组件")
        tabbarVC.id_setupChildViewController(viewController: UIKitViewController(), image:  UIImage(named: "icn_nocolor_icn_uikit"), selectedImage: UIImage(named: "icn_color_icn_uikit"), title: "IDealistUIKit")
        tabbarVC.id_setupChildViewController(viewController: UtilsViewController(), image:  UIImage(named: "icn_nocolor_icn_utils"), selectedImage: UIImage(named: "icn_color_icn_utils"), title: "IDealistUtils")
        UIApplication.shared.keyWindow?.rootViewController = tabbarVC
        
        // 解决ios12 pop时tabbar的闪烁问题
        UITabBar.appearance().isTranslucent = false
    }
}
