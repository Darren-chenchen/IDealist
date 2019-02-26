//
//  BaseNavViewController.swift
//
//  Created by darren on 2017/9/12.
//  Copyright © 2017年 陈亮陈亮. All rights reserved.
//

import UIKit

open class IDBaseNavViewController: UINavigationController {

    override open func viewDidLoad() {
        super.viewDidLoad()
        
    }    
    //push时候自动隐藏bottomBar
    override open func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if children.count > 0 {
            // push时隐藏tabBar
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    override open func popViewController(animated: Bool) -> UIViewController? {
        return  super.popViewController(animated: animated)
    }
    

}
