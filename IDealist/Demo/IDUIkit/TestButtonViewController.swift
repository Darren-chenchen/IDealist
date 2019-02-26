//
//  TestButtonViewController.swift
//  IDUIKit-ios
//
//  Created by darren on 2018/12/7.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit
import SnapKit
    

class TestButtonViewController: IDBaseViewController {
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView.init(frame: CGRect.init(x: 0, y: KNavgationBarHeight, width: KScreenWidth, height: KScreenHeight-KNavgationBarHeight))
        scroll.backgroundColor = UIColor.groupTableViewBackground
        return scroll
    }()
    lazy var titleLabel1: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: 15, y: 0, width: KScreenWidth-30, height: 30))
        label.textColor = UIColor.init(redValue: 155, green: 155, blue: 155, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "主按钮"
        return label
    }()
    lazy var titleLabel2: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: 15, y: bottomView1.frame.maxY, width: KScreenWidth-30, height: 30))
        label.textColor = UIColor.init(redValue: 155, green: 155, blue: 155, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "按钮阴影"
        return label
    }()
    lazy var bottomView1: UIView = {
        let bottom = UIView.init(frame: CGRect.init(x: 0, y: 30, width: KScreenWidth, height: 560))
        bottom.backgroundColor = UIColor.white
        return bottom
    }()
    lazy var bottomView2: UIView = {
        let bottom = UIView.init(frame: CGRect.init(x: 0, y: titleLabel2.frame.maxY, width: KScreenWidth, height: 500))
        bottom.backgroundColor = UIColor.white
        return bottom
    }()
    lazy var btn1: IDButton = {
        let btn = IDButton.init(frame: CGRect.init(x: 15, y: 12, width: KScreenWidth-30, height: 48))
        btn.setTitle("Primary类型的按钮", for: UIControl.State.normal)
        btn.id_type = .primary
        return btn
    }()
    lazy var btn2: IDButton = {
        let btn = IDButton.init(frame: CGRect.init(x: 15, y: btn1.frame.maxY + 12, width: KScreenWidth-30, height: 48))
        btn.setTitle("Normal类型的按钮", for: UIControl.State.normal)
        return btn
    }()
    lazy var btn3: IDButton = {
        let btn = IDButton.init(frame: CGRect.init(x: 15, y: btn2.frame.maxY + 12, width: KScreenWidth-30, height: 48))
        btn.setTitle("警告按钮 Warning", for: UIControl.State.normal)
        btn.id_type = .error
        return btn
    }()
    lazy var btn4: IDButton = {
        let btn = IDButton.init(frame: CGRect.init(x: 15, y: btn3.frame.maxY + 12, width: KScreenWidth-30, height: 48))
        btn.setImage(UIImage(named: "cutting_ic_flashlight_off1"), for: UIControl.State.normal)
        btn.setTitle("imageLeft类型的按钮", for: UIControl.State.normal)
        btn.id_type = .primary
        return btn
    }()
    lazy var btn5: IDButton = {
        let btn = IDButton.init(frame: CGRect.init(x: 15, y: btn4.frame.maxY + 12, width: KScreenWidth-30, height: 48))
        btn.setImage(UIImage(named: "cutting_ic_flashlight_off1"), for: UIControl.State.normal)
        btn.setTitle("imageRight类型的按钮", for: UIControl.State.normal)
        btn.id_imagePosition = .right
        btn.id_type = .primary
        return btn
    }()
    lazy var btn6: IDButton = {
        let btn = IDButton.init(frame: CGRect.init(x: 15, y: btn5.frame.maxY + 12, width: KScreenWidth-30, height: 78))
        btn.setImage(UIImage(named: "cutting_ic_flashlight_off1"), for: UIControl.State.normal)
        btn.setTitle("imageTop类型的按钮", for: UIControl.State.normal)
        btn.id_imagePosition = .top
        btn.id_type = .primary
        return btn
    }()
    lazy var btn7: IDButton = {
        let btn = IDButton.init(frame: CGRect.init(x: 15, y: btn6.frame.maxY + 12, width: KScreenWidth-30, height: 78))
        btn.setImage(UIImage(named: "cutting_ic_flashlight_off1"), for: UIControl.State.normal)
        btn.setTitle("imageBottom类型的按钮", for: UIControl.State.normal)
        btn.id_imagePosition = .bottom
        btn.id_type = .primary
        return btn
    }()
    lazy var btn8: IDButton = {
        let btn = IDButton.init(frame: CGRect.init(x: 15, y: btn7.frame.maxY + 12, width: KScreenWidth-30, height: 48))
        btn.setTitle("主按钮loading", for: UIControl.State.normal)
        btn.id_type = .loading
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btn.backgroundColor = IDealistConfig.share.mainColor
        btn.addTarget(self, action: #selector(clickBtn), for: UIControl.Event.touchUpInside)
        btn.id_loadingTitleSpace = 8
        btn.id_startLoading()
        return btn
    }()
    lazy var btn9: IDButton = {
        let btn = IDButton()
        btn.setTitle("不可点击", for: UIControl.State.normal)
        btn.id_disable = true
        btn.id_type = .primary
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        return btn
    }()
    lazy var btn10: IDButton = {
        let btn = IDButton(type: .system)
        btn.setTitle("有阴影的系统按钮", for: UIControl.State.normal)
        btn.id_type = .primary
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        
        btn.layer.shadowColor = IDealistConfig.share.mainColor.cgColor
        btn.layer.shadowOffset = CGSize.init(width: 0, height: 3)
        btn.layer.shadowRadius = 6
        btn.layer.shadowOpacity = 0.3
        
        return btn
    }()
    lazy var btn11: IDButton = {
        let btn = IDButton(type: .system)
        btn.setTitle("有阴影和圆角的系统按钮", for: UIControl.State.normal)
        btn.id_type = .primary
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        
        btn.layer.cornerRadius = 24
        btn.layer.shadowColor = IDealistConfig.share.mainColor.cgColor
        btn.layer.shadowOffset = CGSize.init(width: 0, height: 3)
        btn.layer.shadowRadius = 6
        btn.layer.shadowOpacity = 0.3
        
        return btn
    }()
    lazy var btn12: IDButton = {
        let btn = IDButton(type: .system)
        btn.setTitle("渐变色", for: UIControl.State.normal)
        btn.id_type = .primary
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        
        btn.layer.cornerRadius = 24
        btn.layer.shadowColor = IDealistConfig.share.mainColor.cgColor
        btn.layer.shadowOffset = CGSize.init(width: 0, height: 3)
        btn.layer.shadowRadius = 6
        btn.layer.shadowOpacity = 0.3
        
        //定义渐变的颜色（
        let topColor = UIColor.init(redValue: 94, green: 86, blue: 255, alpha: 1)
        let buttomColor = UIColor.init(redValue: 14, green: 92, blue: 255, alpha: 1)
        let gradientColors = [topColor, buttomColor]
        btn.id_setupGradient(gradientColors: gradientColors, gradientDirection: IDButtonGradientDirection.horizontally, gradientFrame: CGRect.init(x: 0, y: 0, width: KScreenWidth-30, height: 48))
        
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.scrollView)
        
        self.scrollView.addSubview(self.titleLabel1)
        self.scrollView.addSubview(self.bottomView1)
        self.scrollView.addSubview(self.titleLabel2)
        self.scrollView.addSubview(self.bottomView2)
        self.scrollView.contentSize = CGSize.init(width: 0, height: bottomView2.frame.maxY)
        
        self.bottomView1.addSubview(self.btn1)
        self.bottomView1.addSubview(self.btn2)
        self.bottomView1.addSubview(self.btn3)
        self.bottomView1.addSubview(self.btn4)
        self.bottomView1.addSubview(self.btn5)
        self.bottomView1.addSubview(self.btn6)
        self.bottomView1.addSubview(self.btn7)
        self.bottomView1.addSubview(self.btn8)
        
        self.bottomView2.addSubview(self.btn9)
        self.btn9.snp.makeConstraints { (make) in
            make.leading.equalTo(15)
            make.top.equalToSuperview().offset(12)
            make.width.equalTo(KScreenWidth-30)
            make.height.equalTo(48)
        }
        self.bottomView2.addSubview(self.btn10)
        self.btn10.snp.makeConstraints { (make) in
            make.leading.equalTo(15)
            make.top.equalTo(self.btn9.snp.bottom).offset(12)
            make.width.equalTo(KScreenWidth-30)
            make.height.equalTo(48)
        }
        self.bottomView2.addSubview(self.btn11)
        self.btn11.snp.makeConstraints { (make) in
            make.leading.equalTo(15)
            make.top.equalTo(self.btn10.snp.bottom).offset(12)
            make.width.equalTo(KScreenWidth-30)
            make.height.equalTo(48)
        }
        self.bottomView2.addSubview(self.btn12)
        self.btn12.snp.makeConstraints { (make) in
            make.leading.equalTo(15)
            make.top.equalTo(self.btn11.snp.bottom).offset(12)
            make.width.equalTo(KScreenWidth-30)
            make.height.equalTo(48)
        }
    }
    
    @objc func clickBtn() {
        self.btn8.isSelected = !self.btn8.isSelected
        if self.btn8.isSelected {
            self.btn8.id_startLoading()
        } else {
            self.btn8.id_stopLoading()
        }
    }
}
