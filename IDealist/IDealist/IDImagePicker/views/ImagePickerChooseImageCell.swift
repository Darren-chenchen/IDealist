//
//  ImagePickerChooseImageCell.swift
//  ImageDeal
//
//  Created by darren on 2017/7/27.
//  Copyright © 2017年 陈亮陈亮. All rights reserved.
//

import UIKit
import Photos

typealias imagePickerChooseImageCellClouse = (Bool) -> ()

class ImagePickerChooseImageCell: UICollectionViewCell {

    @IBOutlet weak var chooseBottomView: UIView!
    @IBOutlet weak var vedioImageView: UIImageView!
    @IBOutlet weak var timerLable: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var iconView: UIImageView!
    
    lazy var chooseView: ChooseView = {
        let choose = ChooseView.show()
        choose.frame = CGRect.init(x: 0, y: 0, width: 38, height: 38)
        choose.common()
        return choose
    }()
    
    @objc let btnBackColor = UIColor(white: 0, alpha: 0.6)
    // 视频和照片只能选择一种，不能同时选择,默认可以同时选择
    @objc var onlyChooseImageOrVideo: Bool = false
    
    @objc var imagePickerChooseImage: imagePickerChooseImageCellClouse?
    
    var representedAssetIdentifier = ""
    
    var indexP: IndexPath?
    
    
    @objc var model: CLImagePickerPhotoModel? {
        didSet{
            
            // 视频时长
            self.timerLable.text = model?.videoLength
            
            // 视频底部阴影
            if model?.phAsset?.mediaType == .video {
                self.bottomView.isHidden = false
            } else {
                self.bottomView.isHidden = true
            }
            
            // 是否选中
            if self.model?.isSelect ?? false {
                let index = CLPickersTools.instence.getIndexOfImage(asset: model?.phAsset ?? PHAsset())
                if index == nil {
                    self.chooseView.num = nil
                } else {
                    self.chooseView.num = index! + 1
                }
            } else {
                self.chooseView.num = nil
            }
            
            setupCellCover()
        }
    }
    
    // 设置cell的阴影
    @objc func setupCellCover() {
        // 视频，图片只能选择1中
        if self.onlyChooseImageOrVideo {
            if self.chooseView.num != nil {
                self.iconView.alpha = 0.5
                self.backgroundColor = UIColor.white
            } else {
                self.iconView.alpha = (self.model?.onlyChooseImageOrVideo ?? false) ? 0.5:1
                self.backgroundColor = UIColor(white: 0, alpha: 0.8)
            }
        } else {
            self.iconView.alpha = self.chooseView.num != nil ? 0.5:1
            self.backgroundColor = UIColor.white
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        CLPickersTools.instence.setupBottomViewGradient(superView: self.bottomView)
        self.bottomView.bringSubviewToFront(self.timerLable) // 防止渐变色同化label
        self.bottomView.bringSubviewToFront(self.vedioImageView)
        
        self.iconView.isUserInteractionEnabled = true
        
        self.iconView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(clickIconView(ges:))))
        
        self.chooseBottomView.addSubview(self.chooseView)
        self.chooseView.chooseClouse = {[weak self]() in
            self?.clickChooseBtn()
        }
    }
    
    @objc func clickIconView(ges:UITapGestureRecognizer) {
        if self.model?.phAsset == nil {
            return
        }
        
        // 视频图片只能选择一种
        if self.onlyChooseImageOrVideo {
            if (self.model?.onlyChooseImageOrVideo ?? false) {
                return
            }
        }

        // 相册
        if self.model?.phAsset?.mediaType == .image {
            _ = CLImageAmplifyView.setupAmplifyViewWithUITapGestureRecognizer(tap: ges, superView: self.contentView,originImageAsset:(self.model?.phAsset)!,isSingleChoose:false, singleModelImageCanEditor: false,isSelect: (self.model?.isSelect ?? false))
        }
        // 视频
        if self.model?.phAsset?.mediaType == .video {
            _ = CLVideoPlayView.setupAmplifyViewWithUITapGestureRecognizer(tap: ges, superView: self.contentView,originImageAsset:(self.model?.phAsset)!, isSingleChoose: false)
        }
    }
    
    func clickChooseBtn() {
        
        if self.model?.phAsset == nil {
            return
        }
        
        if self.chooseView.num == nil { // 未选中
            // 判断是否超过限制
            let maxCount = UserDefaults.standard.integer(forKey: CLImagePickerMaxImagesCount)
            if CLPickersTools.instence.getSavePictureCount() >= maxCount {
                
                PopViewUtil.alert(message:String(format: maxPhotoCountStr, maxCount), leftTitle: "", rightTitle: knowStr, leftHandler: {
                    
                }, rightHandler: {
                    
                })
                return
            }
        }
        
        if self.onlyChooseImageOrVideo {
            if (self.model?.onlyChooseImageOrVideo ?? false) {
                PopViewUtil.alert(message:imageAndVideoOnlyOneStr, leftTitle: knowStr, rightTitle: "", leftHandler: {
                    
                }, rightHandler: { 
                    
                })
                return
            }
        }
        
        if self.chooseView.num == nil { // 未选中
            self.model?.isSelect = true

            let num = CLPickersTools.instence.getSavePictureCount()
            self.chooseView.num = num + 1
            // 如果是视频和照片只能选择一种，先判断用户第一次选择的是视频还是照片，并记录下来
            if self.onlyChooseImageOrVideo {
                if CLPickersTools.instence.getSavePictureCount() == 0 {
                    UserDefaults.standard.set(self.model?.phAsset?.mediaType.rawValue, forKey: UserChooserType)
                    UserDefaults.standard.synchronize()
                    CLNotificationCenter.post(name: NSNotification.Name(rawValue:OnlyChooseImageOrVideoNotic), object: self.model?.phAsset?.mediaType.rawValue)
                }
            }
            
            CLPickersTools.instence.saveIndexPath(indexPath: self.indexP ?? IndexPath())
            CLPickersTools.instence.savePicture(asset: (self.model?.phAsset)!, isAdd: true)
            
            if imagePickerChooseImage != nil {
                imagePickerChooseImage!(false)  // false, 代表选中，选中不需要刷新
            }
        } else { // 已选择，现在取消
            self.model?.isSelect = false

            self.chooseView.num = nil
            
            CLPickersTools.instence.delectIndexPath(indexPath: self.indexP ?? IndexPath())
            
            CLPickersTools.instence.savePicture(asset: (self.model?.phAsset)!, isAdd: false)
            
            if self.onlyChooseImageOrVideo {
                if CLPickersTools.instence.getSavePictureCount() == 0 {
                    // 判断是不是所有都取消了，如果是记得清除记录用户第一次选择的类型（照片或者视频）
                    UserDefaults.standard.set(0, forKey: UserChooserType)
                    UserDefaults.standard.synchronize()
                    
                    // 发送通知，更新模型的状态
                    CLNotificationCenter.post(name: NSNotification.Name(rawValue:OnlyChooseImageOrVideoNoticCencel), object: nil)
                }
            }
            
            if imagePickerChooseImage != nil {
                imagePickerChooseImage!(true)
            }
        }
        
        setupCellCover()
    }
    
//    func setselectimg() {
//        let img = UIImage(named: "photo_sel_photoPicker2", in: BundleUtil.getCurrentBundle(), compatibleWith: nil)?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
//        self.chooseImageBtn.setBackgroundImage(img, for: .normal)
//        self.chooseImageBtn.tintColor = CLPickersTools.instence.tineColor
//    }
}
