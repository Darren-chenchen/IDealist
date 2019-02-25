//
//  CLImagePickerCamaroCell.swift
//  ImageDeal
//
//  Created by darren on 2017/8/2.
//  Copyright © 2017年 陈亮陈亮. All rights reserved.
//

import UIKit

typealias clickCamaroCellClouse = () -> ()

class CLImagePickerCamaroCell: UICollectionViewCell {
    
    @objc var clickCamaroCell: clickCamaroCellClouse?
    
    @objc lazy var iconView: UIImageView = {
        let img = UIImageView.init(frame:  CGRect(x: 0, y: 0, width: cellH, height: cellH))
        
        img.image = UIImage(named: "takePicture", in: BundleUtil.getCurrentBundle(), compatibleWith: nil)
        img.isUserInteractionEnabled = true
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.iconView)
        self.iconView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(clickImage)))
    }
    
    @objc func clickImage() {
        if clickCamaroCell != nil {
            self.clickCamaroCell!()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.iconView.frame = CGRect(x: 0, y: 0, width: cellH, height: cellH)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
