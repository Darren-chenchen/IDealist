//
//  TestArrayViewController.swift
//  Ideal-IOS
//
//  Created by darren on 2018/12/5.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit
   

class TestArrayViewController: IDBaseViewController {

    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label1: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.id_navTitle = "数组处理"
        
        self.label1.text = "[1,1,2,2,3,3,4,4]"
        
        self.label2.text = "[1, 2, 3, 4]"
        
        let arr = [1,1,2,2,3,3,4,4]
        let arr2 = arr.id_filterDuplicates({$0})
        print(arr2)
    }

}
