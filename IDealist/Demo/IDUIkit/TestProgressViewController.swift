//
//  TestProgressViewController.swift
//  IDUIKit-ios
//
//  Created by darren on 2018/12/3.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit
   
    
class TestProgressViewController: IDBaseViewController {

    @IBOutlet weak var circleView: IDProgressCircleView!
    @IBOutlet weak var nibProgressView: IDProgressCircleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.id_navTitle = "IDProgressView"
        self.view.backgroundColor = UIColor.groupTableViewBackground
        self.nibProgressView.id_value = 50
        
        // circleView的宽高是80
        self.circleView.id_type = .pie
        self.circleView.id_value = 50
    }
    @IBAction func clickSider(_ sender: Any) {
        let value = (sender as! UISlider).value * 100
        
        self.nibProgressView.id_value = CGFloat(value)
    }
    @IBAction func clickSlider2(_ sender: Any) {
        let value = (sender as! UISlider).value * 100
        self.circleView.id_value = CGFloat(value)
    }
}
