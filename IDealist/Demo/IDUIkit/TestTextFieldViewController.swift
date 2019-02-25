//
//  TestTextFieldViewController.swift
//  IDUIKit-ios
//
//  Created by darren on 2018/12/3.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit

class TestTextFieldViewController: IDBaseViewController {

    @IBOutlet weak var textF1: IDTextField!
    
    @IBOutlet weak var textF2: IDTextField!
    
    @IBOutlet weak var textF3: IDTextField!
    @IBOutlet weak var textF4: IDTextField!
    @IBOutlet weak var textF5: IDTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.id_navTitle = "IDTextField"

        self.view.backgroundColor = UIColor.groupTableViewBackground

        self.textF1.maxLength = 10
        
        self.textF2.onlyNumberAndPoint = true
        self.textF2.pointLength = 2
        
        self.textF3.onlyNumber = true
        
        self.textF4.allowEmoji = false
        
        self.textF5.predicateString = "^[a-z0－9A-Z]*$"
    }
}
