//
//  TestIDSegmentedViewController.swift
//  IDUIKit-ios
//
//  Created by darren on 2018/12/5.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit
   
    
class TestIDSegmentedViewController: IDBaseViewController {

    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var seg: IDSegmentedView!
    @IBOutlet weak var seg1: IDSegmentedView!
    
    lazy var selectView: IDSelectView = {
        let select = IDSelectView.init(frame: CGRect.init(x: 0, y: 290, width: KScreenWidth, height: 50))
        select.id_titles = ["待支付", "已支付", "待发货"]
        return select
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.id_navTitle = "IDSegmentedView"
        self.view.backgroundColor = UIColor.groupTableViewBackground

        self.seg.setImage(UIImage(named: "ic_new"), forSegmentAt: 0)
        
        self.seg1.id_setSegmentStyle(normalColor: UIColor.white, selectedColor: UIColor.red, dividerColor: UIColor.groupTableViewBackground)
        
        self.view.addSubview(self.selectView)
        
        self.moreBtn.layer.cornerRadius = 15
    }

    @IBAction func clickMoreBtrn(_ sender: Any) {
        let vc = TestIDSelectViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
