//
//  BaseNavViewController.swift
//  CloudscmSwift
//
//  Created by Darren on 17/5/2.
//  Copyright © 2017年 RexYoung. All rights reserved.
//

import UIKit

open class IDBaseViewController: UIViewController {

    /// 自定义导航栏
    open lazy var id_customNavBar: IDCustomNavgationView = {
        let nav = IDCustomNavgationView()
        nav.frame = CGRect(x: 0, y: 0, width: KScreenWidth, height: KNavgationBarHeight)
        nav.backgroundColor = UIColor.white
        return nav
    }()
    /// 右边第一个按钮
    open lazy var id_rightBtn: UIButton = {
        let btn = UIButton()
        btn.frame = CGRect.zero
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.addTarget(self, action: #selector(IDBaseViewController.rightBtnClick), for: UIControl.Event.touchUpInside)
        return btn
    }()
    /// 右边第二个按钮
    open lazy var id_rightBtnTwo: UIButton = {
        let btn = UIButton()
        btn.frame = CGRect.zero
        btn.adjustsImageWhenHighlighted = false
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.addTarget(self, action: #selector(IDBaseViewController.rightBtnTwoClick), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    /// 标题
    open var id_navTitle = "" {
        didSet{
            id_customNavBar.titleLable.text = id_navTitle
        }
    }
    open var id_navTitleColor = UIColor.black {
        didSet{
            id_customNavBar.titleLable.textColor = id_navTitleColor
        }
    }
    open var id_navBgColor = UIColor.white {
        didSet{
            id_customNavBar.backgroundColor = id_navBgColor
        }
    }
    // 返回按钮
    open lazy var id_backBtn: UIButton = {
        let btn = UIButton()
        btn.frame = CGRect.zero
        btn.addTarget(self, action: #selector(IDBaseViewController.backBtnclick), for: .touchUpInside)
        btn.setImage(UIImage(named: "btn_back", in: BundleUtil.getCurrentBundle(), compatibleWith: nil), for: .normal)
        return btn
    }()
    
    /// 设置右边按钮的宽度，默认宽度64
    open var rightBtnWidthConstraint = NSLayoutConstraint()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.isTranslucent = false
        
        setupNav()
        
        setupLayout()
    }
    func setupLayout() {
        let titleY: CGFloat = UIDevice.id_isX() == true ? 40:20
        
        self.id_customNavBar.translatesAutoresizingMaskIntoConstraints = false
        self.id_rightBtnTwo.translatesAutoresizingMaskIntoConstraints = false
        self.id_rightBtn.translatesAutoresizingMaskIntoConstraints = false
        self.id_backBtn.translatesAutoresizingMaskIntoConstraints = false
        
        // 导航栏
        self.id_customNavBar.addConstraint(NSLayoutConstraint.init(item: self.id_customNavBar, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 0, constant: KNavgationBarHeight))
        self.view.addConstraints([
            NSLayoutConstraint.init(item: self.id_customNavBar, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: self.id_customNavBar, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: self.id_customNavBar, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
            ])
        // 右边的按钮
        self.rightBtnWidthConstraint = NSLayoutConstraint.init(item: self.id_rightBtn, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 0, constant: 64)
        self.id_rightBtn.addConstraint(NSLayoutConstraint.init(item: self.id_rightBtn, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 0, constant: 44))
        self.id_rightBtn.addConstraint(self.rightBtnWidthConstraint)
        self.id_customNavBar.addConstraints([
            NSLayoutConstraint.init(item: self.id_rightBtn, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.id_customNavBar, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: titleY),
            NSLayoutConstraint.init(item: self.id_rightBtn, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.id_customNavBar, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
            ])
        
        // 返回按钮
        self.id_backBtn.addConstraint(NSLayoutConstraint.init(item: self.id_backBtn, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 0, constant: 44))
        self.id_backBtn.addConstraint(NSLayoutConstraint.init(item: self.id_backBtn, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 0, constant: 44))
        self.id_customNavBar.addConstraints([
            NSLayoutConstraint.init(item: self.id_backBtn, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.id_customNavBar, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: titleY),
            NSLayoutConstraint.init(item: self.id_backBtn, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.id_customNavBar, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
            ])
        
        
        // id_rightBtnTwo
        self.id_rightBtnTwo.addConstraint(NSLayoutConstraint.init(item: self.id_rightBtnTwo, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 0, constant: 44))
        self.id_rightBtnTwo.addConstraint(NSLayoutConstraint.init(item: self.id_rightBtnTwo, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 0, constant: 64))
        self.id_customNavBar.addConstraints([
            NSLayoutConstraint.init(item: self.id_rightBtnTwo, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.id_rightBtn, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: self.id_rightBtnTwo, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.id_rightBtn, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
            ])
    }
    
    fileprivate func setupNav(){
        
        // 添加导航栏
        self.view.addSubview(self.id_customNavBar)
        
        // 右边按钮
        self.id_customNavBar.addSubview(self.id_rightBtn)
        self.id_customNavBar.addSubview(self.id_rightBtnTwo)
        self.id_customNavBar.addSubview(self.id_backBtn)
        
        // 多层push才显示返回按钮
        if self.navigationController != nil {
            if ((self.navigationController?.children.count)!>1){
                self.id_backBtn.isHidden = false
            } else {
                self.id_backBtn.isHidden = true
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.view.bringSubviewToFront(self.id_customNavBar)
        }
    }
    
    @objc open func rightBtnTwoClick() {
        
    }
    
    @objc open func rightBtnClick(){
        
    }
    @objc open func backBtnclick(){
        let VCArr = self.navigationController?.viewControllers
        if VCArr == nil {
            self.dismiss(animated: true, completion: nil)
            return
        }
        if VCArr!.count > 1 {
            self.navigationController!.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    //状态栏颜色默认为黑色
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    //点击空白处, 回收键盘
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
}
