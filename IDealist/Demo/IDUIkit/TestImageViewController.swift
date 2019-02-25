//
//  TestImageViewController.swift
//  IDUIKit-ios
//
//  Created by darren on 2018/12/4.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit

class TestImageViewController: IDBaseViewController {

    lazy var imgView: UIImageView = {
        let img = UIImageView.init(frame: CGRect.init(x: 10, y:  KNavgationBarHeight + 40 + 40, width: 90, height: 90))
        return img
    }()
    lazy var label: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: 10, y: KNavgationBarHeight + 40, width: KScreenWidth, height: 30))
        label.text = "通过颜色生成一张图片"
        return label
    }()
    lazy var label2: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: 10, y: KNavgationBarHeight + 160, width: KScreenWidth-20, height: 80))
        label.text = "self.imgView.image = UIImage.id_renderImageWithColor(UIColor.purple, size: CGSize.init(width: 80, height: 80))"
        label.numberOfLines = 0
        label.textColor = UIColor.lightGray
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.id_navTitle = "IDImage"
        self.view.addSubview(self.label)
        self.view.addSubview(self.imgView)
        self.view.addSubview(self.label2)

        let img = UIImage.id_renderImageWithColor(UIColor.purple, size: CGSize.init(width: 80, height: 80))
        self.imgView.image = img
    }
    
    @objc func clickBtn() {
    }

}
