//
//  IDEditorViewController.swift
//  IDImagePicker-IOS
//
//  Created by darren on 2018/12/6.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit

class IDEditorViewController: UIViewController {

    @IBOutlet weak var bottomHYs: NSLayoutConstraint!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var sureBtn: UIButton!
    
    var model: PreviewModel = PreviewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.iconView.contentMode = .scaleAspectFit
        self.bottomHYs.constant = 60 + SaveAreaHeight
        
        if model.phAsset == nil {
            return
        }

        self.iconView.image = self.model.img
//        CLPickersTools.instence.getAssetOrigin(asset: model.phAsset!) { (img, info) in
//            if img != nil {
//                self.iconView.image = img!
//            } else {  // 说明本地没有需要到iCloud下载
//            }
//        }
    }

    @IBAction func clickCancelBtn(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func clickDoneBtn(_ sender: Any) {
    }
    @IBAction func clickEditorTextBtn(_ sender: Any) {
    }
    @IBAction func clickCutBtn(_ sender: Any) {
    }
}
