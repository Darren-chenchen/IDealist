//
//  TestIDSelectViewController.swift
//  IDUIKit-ios
//
//  Created by darren on 2019/2/22.
//  Copyright © 2019年 陈亮陈亮. All rights reserved.
//

import UIKit
    

class TestIDSelectViewController: IDBaseViewController {

    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView.init(frame: self.view.bounds)
        scroll.backgroundColor = UIColor.groupTableViewBackground
        return scroll
    }()
    lazy var selectView1: IDSelectView = {
        let select = IDSelectView.init(frame: CGRect(x: 0, y: 60, width: KScreenWidth, height: 50))
        select.id_titles = ["猴哥", "青蛙王子", "旺财", "粉红猪", "喜羊羊", "黄焖鸡", "小马哥", "牛魔王", "大象先生", "神龙"]
        select.id_indicatorWidth = 20
        return select
    }()
    
    lazy var selectView2: IDSelectView = {
        let select = IDSelectView.init(frame: CGRect(x: 0, y: self.selectView1.frame.maxY + 30, width: KScreenWidth, height: 50))
        select.id_titles = ["猴哥", "青蛙王子", "旺财", "粉红猪", "喜羊羊", "黄焖鸡", "小马哥", "牛魔王", "大象先生", "神龙"]
        select.id_indicatorEqualWidth = true
        return select
    }()
    
    lazy var selectView3: IDSelectView = {
        let select = IDSelectView.init(frame: CGRect(x: 0, y: self.selectView2.frame.maxY + 30, width: KScreenWidth, height: 50))
        select.id_titles = ["猴哥", "青蛙王子", "旺财", "粉红猪", "喜羊羊", "黄焖鸡", "小马哥", "牛魔王", "大象先生", "神龙"]
        select.id_indicatorEqualWidth = true
        select.id_itemSpacing = 50
        return select
    }()
    
    lazy var selectView4: IDSelectView = {
        let select = IDSelectView.init(frame: CGRect(x: 0, y: self.selectView3.frame.maxY + 30, width: KScreenWidth, height: 50))
        select.id_titles = ["猴哥猴哥猴哥猴哥猴哥猴哥猴哥猴哥", "青蛙王子", "旺财", "粉红猪"]
        select.id_titleNumberOfLines = 2
        return select
    }()
    lazy var selectView5: IDSelectView = {
        let select = IDSelectView.init(frame: CGRect(x: 0, y: self.selectView4.frame.maxY + 30, width: KScreenWidth, height: 50))
        select.id_titles = ["猴哥", "青蛙王子", "旺财", "粉红猪"]
        select.id_titleNormalColor = UIColor.darkGray
        select.id_titleSelectedColor = UIColor.orange
        select.id_titleNormalFont = UIFont.systemFont(ofSize: 12)
        select.id_titleSelectedFont = UIFont.boldSystemFont(ofSize: 18)
        return select
    }()
    lazy var selectView6: IDSelectView = {
        let select = IDSelectView.init(frame: CGRect(x: 0, y: self.selectView5.frame.maxY + 30, width: KScreenWidth, height: 50))
        select.id_titles = ["猴哥", "青蛙王子", "旺财", "粉红猪"]
        select.id_indicatorType = .ellipse
        select.id_ellipseIndicatorHeight = 20
        select.id_indicatorColor = UIColor.lightGray
        return select
    }()
    
    lazy var selectView7: IDSelectView = {
        let select = IDSelectView.init(frame: CGRect(x: 0, y: self.selectView6.frame.maxY + 30, width: KScreenWidth, height: 50))
        select.numberStringFormatterClosure = {(number) -> String in
            if number > 99 {
                return "99+"
            }
            if number > 999 {
                return "999+"
            }
            return "\(number)"
        }
        select.id_type = .number
        select.id_titles = ["猴哥", "青蛙王子", "旺财", "粉红猪", "喜羊羊", "黄焖鸡", "小马哥"]
        select.id_indicatorEqualWidth = true
        select.id_numbers = [100, 2, 3, 400, 10, 1000, 5]
        return select
    }()
    
    lazy var selectView8: IDSelectView = {
        let select = IDSelectView.init(frame: CGRect(x: 0, y: self.btn1.frame.maxY + 30, width: KScreenWidth, height: 50))
        select.id_type = .dots
        select.id_titles = ["猴哥", "青蛙王子", "旺财", "粉红猪", "喜羊羊", "黄焖鸡", "小马哥"]
        select.id_indicatorEqualWidth = true
        select.id_dotStates = [true, false, false, false, false, false, false]
        return select
    }()
    lazy var selectView9: IDSelectView = {
        let select = IDSelectView.init(frame: CGRect(x: 0, y: self.btn2.frame.maxY + 30, width: KScreenWidth, height: 50))
        select.id_type = .dots
        select.id_titles = ["猴哥", "青蛙王子", "旺财", "粉红猪", "喜羊羊", "黄焖鸡", "小马哥"]
        select.id_indicatorEqualWidth = true
        select.id_dotStates = [true, true, true, true, false, false, false]
        select.id_dotSize = CGSize.init(width: 6, height: 6)
        select.id_dotColor = UIColor.magenta
        return select
    }()
    lazy var btn1: UIButton = {
        let btn = UIButton.init(frame: CGRect(x: 20, y: self.selectView7.frame.maxY + 10, width: 200, height: 40))
        btn.setTitle("点击更新数量", for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(clickBtn1), for: UIControl.Event.touchUpInside)
        btn.backgroundColor = UIColor.magenta
        btn.layer.cornerRadius = 20
        return btn
    }()
    lazy var btn2: UIButton = {
        let btn = UIButton.init(frame: CGRect(x: 20, y: self.selectView8.frame.maxY + 10, width: 200, height: 40))
        btn.setTitle("点击更新", for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(clickBtn2), for: UIControl.Event.touchUpInside)
        btn.backgroundColor = UIColor.magenta
        btn.layer.cornerRadius = 20
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.id_navTitle = "IDSelectView"

        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.selectView1)
        self.scrollView.addSubview(self.selectView2)
        self.scrollView.addSubview(self.selectView3)
        self.scrollView.addSubview(self.selectView4)
        self.scrollView.addSubview(self.selectView5)
        self.scrollView.addSubview(self.selectView6)
        self.scrollView.addSubview(self.selectView7)
        self.scrollView.addSubview(self.btn1)
        self.scrollView.addSubview(self.selectView8)
        self.scrollView.addSubview(self.btn2)
        self.scrollView.addSubview(self.selectView9)

        self.view.bringSubviewToFront(self.id_customNavBar)
        
        self.scrollView.contentSize = CGSize.init(width: 0, height: KScreenHeight + 300)
    }
    @objc func clickBtn1(){
        selectView7.id_numbers = [2, 2, 2, 2, 2, 2, 2]
    }
    @objc func clickBtn2(){
        selectView8.id_dotStates = [false, false, true, true, true, true, true]
    }
}
