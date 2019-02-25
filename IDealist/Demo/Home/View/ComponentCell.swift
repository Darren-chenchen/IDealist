//
//  ComponentCell.swift
//  ideal
//
//  Created by darren on 2018/8/21.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit

class ComponentCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.white
    }

}
