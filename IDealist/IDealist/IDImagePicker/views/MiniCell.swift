//
//  MiniCell.swift
//  IDImagePicker-IOS
//
//  Created by darren on 2018/12/6.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit

class MiniCell: UICollectionViewCell {
    lazy var iconView: UIImageView = {
        let img = UIImageView.init(frame:  CGRect(x: 0, y: 0, width: self.cl_width, height: self.cl_height))
        img.isUserInteractionEnabled = true
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.iconView)
        self.iconView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(clickImage)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    @objc func clickImage() {
    }
}
