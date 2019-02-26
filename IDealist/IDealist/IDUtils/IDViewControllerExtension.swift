//
//  IDViewControllerUtils.swift
//  Ideal-IOS
//
//  Created by darren on 2018/12/14.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit
public extension UIViewController {
    //MARK: - Returns: 当前控制器
    public func id_getCurrentViewcontroller() -> UIViewController?{
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
