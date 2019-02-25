//
//  SecondViewController.swift
//  IDEmptyView_Example
//
//  Created by implion on 2018/12/7.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
   

class SecondViewController: IDBaseViewController {
    
    var style: IDEmptyView.Style?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.id_navTitle = "IDEmptyView"
        
        view.backgroundColor = UIColor.white
        view.id_empty = IDEmptyView.create().configStyle(style)
        view.id_empty?.backgroundColor = UIColor.init(white: 1.0, alpha: 0.92)
        
        self.view.bringSubviewToFront(self.id_customNavBar)
    }

}
