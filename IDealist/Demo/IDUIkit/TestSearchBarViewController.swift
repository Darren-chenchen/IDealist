//
//  TestSearchBarViewController.swift
//  IDUIKit-ios
//
//  Created by darren on 2018/12/3.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit
   
    

class TestSearchBarViewController: IDBaseViewController {

    @IBOutlet weak var searchBar3: IDSearchBar!
    @IBOutlet weak var searchBar2: IDSearchBar!
    @IBOutlet weak var nibSearchbar: IDSearchBar!
    
    lazy var searchBar4: IDSearchBar = {
        let search = IDSearchBar.init(frame: CGRect.init(x: 0, y: 300, width: KScreenWidth, height: 60))
        return search
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.id_navTitle = "IDSearchBar"
        
        self.view.backgroundColor = UIColor.init(redValue: 245, green: 245, blue: 249, alpha: 1)
        
        self.view.addSubview(self.searchBar4)
        
        self.searchBar2.id_placeHolder = "搜索"
        self.searchBar2.id_containerBgColor = UIColor.white
        
        self.searchBar3.id_showRightBtn = true
        
        self.searchBar4.id_showRightBtn = true
        self.searchBar4.id_cancelButtonTitle = "文本"
        self.searchBar4.id_cornerRadius = 20
    }

}
