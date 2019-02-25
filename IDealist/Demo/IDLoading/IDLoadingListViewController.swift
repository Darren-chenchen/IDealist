//
//  IDLoadingListViewController.swift
//  IdealDemo
//
//  Created by darren on 2018/11/23.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit

class IDLoadingListViewController: IDBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.id_navTitle = "商品列表"
        
        self.view.backgroundColor = UIColor.init(redValue: 245, green: 245, blue: 245, alpha: 1)
        
        IDLoading.id_show(onView: self.view)
    }

}
