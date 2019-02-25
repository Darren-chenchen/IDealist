//
//  IDUpdateManagerTestController.swift
//  IdealDemo
//
//  Created by darren on 2018/11/30.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit

class IDUpdateManagerTestController: IDBaseViewController {

    lazy var btn: UIButton = {
        let btn = UIButton.init(frame: CGRect.init(x: 40, y: KNavgationBarHeight + 50, width: KScreenWidth-80, height: 40))
        btn.setTitle("检查更新", for: .normal)
        btn.backgroundColor = UIColor.red
        btn.layer.cornerRadius = 20
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(clickBtn), for: .touchUpInside)
        return btn
    }()
    
    lazy var btn2: UIButton = {
        let btn = UIButton.init(frame: CGRect.init(x: 40, y: KNavgationBarHeight + 140, width: KScreenWidth-80, height: 40))
        btn.setTitle("检查更新,更换主题色", for: .normal)
        btn.backgroundColor = UIColor.blue
        btn.layer.cornerRadius = 20
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(clickBtn2), for: .touchUpInside)
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.id_navTitle = "检查更新"
        
        self.view.addSubview(self.btn)
        self.view.addSubview(self.btn2)
    }
    
    @objc func clickBtn() {
//        IDUpdateManager.shared.id_setThemeColor(UIColor.red)
//        IDUpdateManager.shared.id_checkVersionUpdate()
//
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
//            self.getCurrentViewcontroller1()?.dismiss(animated: false, completion: nil)
//        }
    }
    
    @objc func clickBtn2() {
//        IDUpdateManager.shared.id_setThemeColor(UIColor.blue)
//        IDUpdateManager.shared.id_checkVersionUpdate(true)
//        
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
//            self.getCurrentViewcontroller1()?.dismiss(animated: false, completion: nil)
//        }
    }
    
    @objc func getCurrentViewcontroller1() -> UIViewController?{
        let rootController = UIApplication.shared.keyWindow?.rootViewController
        if let tabController = rootController as? UITabBarController   {
            if let navController = tabController.selectedViewController as? UINavigationController{
                return navController.children.last
            }else{
                return tabController
            }
        }else if let navController = rootController as? UINavigationController {
            
            return navController.children.last
        }else{
            
            return rootController
        }
    }

}
