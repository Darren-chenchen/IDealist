//
//  CLImageAmplifyView.swift
//  relex_swift
//
//  Created by darren on 17/1/5.
//  Copyright © 2017年 darren. All rights reserved.
//

import UIKit
import Photos
import PhotosUI
import ImageIO
import QuartzCore

typealias singlePictureClickSureBtnClouse = ()->()
typealias singlePictureClickEditorBtnClouse = ()->()

class CLImageAmplifyView: UIView {
    
    private var imageArr: Array<CGImage> = [] // 图片数组（存放每一帧的图片）
    private var timeArr: Array<NSNumber> = [] // 时间数组 (存放每一帧的图片的时间)
    private var totalTime: Float = 0 // gif 动画时间
    
    var originalFrame:CGRect!
    
    @objc let manager = PHImageManager.default()
    var imageRequestID: PHImageRequestID?
    
    // 单选模式下图片是否可以编辑
    @objc var singleModelImageCanEditor: Bool = false
    
    @objc var singlePictureClickSureBtn: singlePictureClickSureBtnClouse?
    @objc var singlePictureClickEditorBtn: singlePictureClickEditorBtnClouse?
    
    var originImageAsset: PHAsset?
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
    lazy var circleBtn: CLCircleView = {
        let btn = CLCircleView.init()
        return btn
    }()
    lazy var lastImageView: UIImageView = {
        let img = UIImageView()
        return img
    }()
    lazy var chooseView: ChooseView = {
        let choose = ChooseView.show()
        choose.frame = CGRect.init(x: 0, y: 0, width: 38, height: 38)
        choose.common()
        choose.chooseClouse = {[weak self] () in
            self?.clickBtn()
        }
        return choose
    }()

    lazy var singleSureBtn: UIButton = {
        let btn = UIButton.init()
        btn.setTitle(sureStr, for: .normal)
        btn.setTitleColor(mainColor, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.addTarget(self, action: #selector(clickSureBtn), for: .touchUpInside)
        return btn
    }()
    lazy var btnEditor: UIButton = {
        let btnEditor = UIButton.init()
        btnEditor.setTitle(editorStr, for: .normal)
        btnEditor.setTitleColor(mainColor, for: .normal)
        btnEditor.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btnEditor.addTarget(self, action: #selector(clickEditorBtn), for: .touchUpInside)
        return btnEditor
    }()
    @objc lazy var bottomView: UIView = {
        let bottom = UIView.init()
        bottom.backgroundColor = UIColor(white: 0, alpha: 0.8)
        return bottom
    }()
    
    @objc static func setupAmplifyViewWithUITapGestureRecognizer(tap:UITapGestureRecognizer,superView:UIView,originImageAsset:PHAsset,isSingleChoose:Bool,singleModelImageCanEditor:Bool,isSelect: Bool) -> CLImageAmplifyView{
        
        let amplifyView = CLImageAmplifyView.init(frame: (UIApplication.shared.keyWindow?.bounds)!)
        UIApplication.shared.keyWindow?.addSubview(amplifyView)
        
        amplifyView.setupUIWithUITapGestureRecognizer(tap: tap, superView: superView,originImageAsset:originImageAsset,isSingleChoose:isSingleChoose,singleModelImageCanEditor:singleModelImageCanEditor,isSelect: isSelect)
        
        return amplifyView
    }
    
    func initLayout() {
        
        let win = UIApplication.shared.keyWindow

        self.bottomView.translatesAutoresizingMaskIntoConstraints = false
        self.translatesAutoresizingMaskIntoConstraints = false
        self.singleSureBtn.translatesAutoresizingMaskIntoConstraints = false
        self.btnEditor.translatesAutoresizingMaskIntoConstraints = false
        self.chooseView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.circleBtn.translatesAutoresizingMaskIntoConstraints = false

        win?.addConstraints([
            NSLayoutConstraint.init(item: self, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: win, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: self, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: win, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: self, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: win, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: self, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: win, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
            ])
        self.addConstraints([
            NSLayoutConstraint.init(item: self.scrollView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: self.scrollView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: self.scrollView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: self.scrollView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
            ])
        
        if self.chooseView.superview == self {
            self.chooseView.addConstraint(NSLayoutConstraint.init(item: self.chooseView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 0, constant: 25))
            self.chooseView.addConstraint(NSLayoutConstraint.init(item: self.chooseView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 0, constant: 25))
            self.addConstraints([
                NSLayoutConstraint.init(item: self.chooseView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 28),
                NSLayoutConstraint.init(item: self.chooseView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: -20)
                ])
        }
        
        if self.bottomView.superview == self {
            let viewH: CGFloat = UIDevice.id_isX() == true ? 44+34:44
            self.bottomView.addConstraint(NSLayoutConstraint.init(item: self.bottomView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 0, constant: viewH))
            self.addConstraints([
                NSLayoutConstraint.init(item: self.bottomView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0),
                NSLayoutConstraint.init(item: self.bottomView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0),
                NSLayoutConstraint.init(item: self.bottomView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
                ])
        }
        
        if self.singleSureBtn.superview == self.bottomView {
            self.singleSureBtn.addConstraint(NSLayoutConstraint.init(item: self.singleSureBtn, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 0, constant: 44))
            self.singleSureBtn.addConstraint(NSLayoutConstraint.init(item: self.singleSureBtn, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 0, constant: 80))
            self.bottomView.addConstraints([
                NSLayoutConstraint.init(item: self.singleSureBtn, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.bottomView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0),
                NSLayoutConstraint.init(item: self.singleSureBtn, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.bottomView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
                ])
        }

        if self.btnEditor.superview == self.bottomView {
            self.btnEditor.addConstraint(NSLayoutConstraint.init(item: self.btnEditor, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 0, constant: 44))
            self.btnEditor.addConstraint(NSLayoutConstraint.init(item: self.btnEditor, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 0, constant: 80))
            self.bottomView.addConstraints([
                NSLayoutConstraint.init(item: self.btnEditor, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.bottomView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0),
                NSLayoutConstraint.init(item: self.btnEditor, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.bottomView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
                ])
        }
        if self.circleBtn.superview == self {
            self.circleBtn.addConstraint(NSLayoutConstraint.init(item: self.circleBtn, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 0, constant: 30))
            self.circleBtn.addConstraint(NSLayoutConstraint.init(item: self.circleBtn, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 0, constant: 30))
            self.addConstraints([
                NSLayoutConstraint.init(item: self.circleBtn, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: -10),
                NSLayoutConstraint.init(item: self.circleBtn, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: -80)
                ])
        }
    }
    private func setupUIWithUITapGestureRecognizer(tap:UITapGestureRecognizer,superView:UIView,originImageAsset: PHAsset,isSingleChoose:Bool,singleModelImageCanEditor:Bool,isSelect: Bool) {
        
        self.singleModelImageCanEditor = singleModelImageCanEditor
        self.originImageAsset = originImageAsset
        
        //scrollView作为背景
        self.scrollView.frame = (UIApplication.shared.keyWindow?.bounds)!
        self.scrollView.backgroundColor = UIColor.black
        self.scrollView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.clickBgView(tapBgView:))))
        
        // 点击的图片
        let picView = tap.view
        
        self.lastImageView.image = (tap.view as! UIImageView).image
        self.lastImageView.frame = (self.scrollView.convert((picView?.frame)!, from: superView))
        self.scrollView.addSubview((self.lastImageView))
        
        self.addSubview(self.scrollView)
        
        CLPickersTools.instence.getAssetOrigin(asset: originImageAsset) { (img, info) in
            if img != nil {
                // 等界面加载出来再复制，放置卡顿效果
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                    self.lastImageView.image = img!

                    self.dealGif(info: info,originImageAsset:originImageAsset)
                }
            } else {  // 说明本地没有需要到iCloud下载

                self.addSubview(self.circleBtn)

                let option = PHImageRequestOptions()
                option.isNetworkAccessAllowed = true

                option.progressHandler = {
                (progress, error, stop, info) in
                    DispatchQueue.main.async(execute: {
                        print(progress, info ?? "0000",error ?? "error")
                        if progress*100 < 10 {
                            self.circleBtn.value = 10
                        } else {
                            self.circleBtn.value = CGFloat(progress*100)
                        }
                    })
                }

                self.imageRequestID = self.manager.requestImageData(for: originImageAsset, options: option, resultHandler: { (imageData, string, imageOrientation, info) in
                    if imageData != nil {
                        self.lastImageView.image = UIImage.init(data: imageData!)
                        self.circleBtn.removeFromSuperview()

                        self.dealGif(info: info,originImageAsset:originImageAsset)
                    }
                })
            }
        }

        self.originalFrame = self.lastImageView.frame

        //最大放大比例
        self.scrollView.maximumZoomScale = 1.5
        self.scrollView.delegate = self

        if isSingleChoose {   // 单选
            self.setupBottomView()
        } else {  // 多选
            self.addSubview(self.chooseView)
            if isSelect {
                self.setselectimg()
            } else {
                self.chooseView.isSelect = false
            }
        }
        
        self.initLayout()

        self.show()
    }
    func show() {
        var frameImg = self.lastImageView.frame
        frameImg.size.width = (self.scrollView.cl_width)
        let bili = (self.lastImageView.image?.size.height)! / (self.lastImageView.image?.size.width)!
        let h =  (frameImg.size.width) * bili
        frameImg.size.height = h
        frameImg.origin.x = 0
        frameImg.origin.y = ((self.scrollView.frame.size.height) - (h)) * 0.5
        if (frameImg.size.height) > UIScreen.main.bounds.height {
            frameImg.origin.y = 0
            self.scrollView.contentSize = CGSize(width: 0, height: (frameImg.size.height))
        }
        UIView.animate(withDuration: 0.5) {
            self.lastImageView.frame = frameImg
        }
    }
    @objc func clickBtn() {
        self.chooseView.isSelect = !self.chooseView.isSelect
        let model = PreviewModel()
        model.phAsset = self.originImageAsset ?? PHAsset()
        if self.chooseView.isSelect {
            // 判断是否超过限制
            let maxCount = UserDefaults.standard.integer(forKey: CLImagePickerMaxImagesCount)
            if CLPickersTools.instence.getSavePictureCount() >= maxCount {
                
                PopViewUtil.alert(message:String(format: maxPhotoCountStr, maxCount), leftTitle: "", rightTitle: knowStr, leftHandler: {
                    
                }, rightHandler: {
                    
                })
                return
            }
            self.setselectimg()
            model.isCheck = true
            CLPickersTools.instence.savePicture(asset: (model.phAsset)!, isAdd: true)
        } else {
            self.chooseView.isSelect = false
            model.isCheck = false
            CLPickersTools.instence.savePicture(asset: (model.phAsset)!, isAdd: false)
        }
        // 通知列表刷新状态
        CLNotificationCenter.post(name: NSNotification.Name(rawValue:PreviewForSelectOrNotSelectedNotic), object: model)
    }
    
     @objc func clickBgView(tapBgView:UITapGestureRecognizer){
        
        self.bottomView.removeFromSuperview()
        
        self.scrollView.contentOffset = CGPoint(x: 0, y: 0)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.lastImageView.frame = self.originalFrame
            self.lastImageView.contentMode = .scaleAspectFill
            self.lastImageView.layer.masksToBounds = true
            
            tapBgView.view?.backgroundColor = UIColor.clear
            self.circleBtn.removeFromSuperview()
            self.chooseView.alpha = 0
            
            if self.imageRequestID != nil {
                self.manager.cancelImageRequest(self.imageRequestID!)
            }
            
        }) { (true:Bool) in
            tapBgView.view?.removeFromSuperview()
            self.imageRequestID = nil
            self.lastImageView.removeFromSuperview()
            self.chooseView.removeFromSuperview()
            self.scrollView.removeFromSuperview()
            self.removeFromSuperview()
        }
    }
    
    @objc func setupBottomView() {
        // 编辑按钮
        if self.singleModelImageCanEditor == true {
            self.bottomView.addSubview(self.btnEditor)
        }
        self.bottomView.addSubview(self.singleSureBtn)
        self.addSubview(self.bottomView)
    }
    
    @objc func clickSureBtn() {
        
        if self.singlePictureClickSureBtn != nil {
            self.singlePictureClickSureBtn!()
        }
        
        self.lastImageView.removeFromSuperview()
        self.scrollView.removeFromSuperview()
        self.removeFromSuperview()
        
        if self.imageRequestID != nil {
            self.manager.cancelImageRequest(self.imageRequestID!)
            self.imageRequestID = nil
        }
    }
    
    // 编辑图片
    @objc func clickEditorBtn() {
        if self.singlePictureClickEditorBtn != nil {
            self.singlePictureClickEditorBtn!()
        }
        
        self.lastImageView.removeFromSuperview()
        self.scrollView.removeFromSuperview()
        self.removeFromSuperview()
        
        if self.imageRequestID != nil {
            self.manager.cancelImageRequest(self.imageRequestID!)
            self.imageRequestID = nil
        }
    }
}

//返回可缩放的视图
extension CLImageAmplifyView:UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.lastImageView
    }
}

extension CLImageAmplifyView: CAAnimationDelegate {
    func dealGif(info: [AnyHashable:Any]?,originImageAsset: PHAsset) {
        if info != nil {
            let url = (info!["PHImageFileURLKey"] ?? "") as? NSURL
            let urlstr  = url?.path ?? ""
            if urlstr.contains(".gif") || urlstr.contains(".GIF") {
                let option = PHImageRequestOptions()
                option.isSynchronous = true
                self.manager.requestImageData(for: originImageAsset, options: option, resultHandler: { (gifImgData, str, imageOrientation, info) in
                    if gifImgData != nil {
                        self.createKeyFram(imgData: gifImgData!)
                    }
                })
            }
        }
    }
    // 获取GIF 图片的每一帧有关的东西 比如：每一帧的图片、每一帧图片执行的时间
    func createKeyFram(imgData: Data) {
        
        let gifSource = CGImageSourceCreateWithData(imgData as CFData, nil)
        if gifSource == nil {
            return
        }
        let imageCount = CGImageSourceGetCount(gifSource!) // 总共图片张数
        
        for i in 0..<imageCount {
            let imageRef = CGImageSourceCreateImageAtIndex(gifSource!, i, nil) // 取得每一帧的图
            self.imageArr.append(imageRef!)
            
            let sourceDict = CGImageSourceCopyPropertiesAtIndex(gifSource!, i, nil) as NSDictionary?
            let gifDict = sourceDict?[String(kCGImagePropertyGIFDictionary)] as? NSDictionary
            let time = gifDict?[String(kCGImagePropertyGIFUnclampedDelayTime)] as? NSNumber // 每一帧的动画时间
            self.timeArr.append(time ?? 0)
            self.totalTime += time?.floatValue ?? 0
            
            // 获取图片的尺寸 (适应)
            let imageWidth = sourceDict?[String(kCGImagePropertyPixelWidth)] as? NSNumber
            let imageHeight = sourceDict?[String(kCGImagePropertyPixelHeight)] as? NSNumber
            
            guard let imageWidth_v = imageWidth else {
                return
            }
            guard let imageHeight_v = imageHeight else {
                return
            }
            if (imageWidth_v.floatValue / imageHeight_v.floatValue) != Float(self.frame.size.width/self.frame.size.height) {
                self.fitScale(imageWidth: CGFloat(imageWidth_v.floatValue), imageHeight: CGFloat(imageHeight_v.floatValue))
            }
        }
        
        self.showAnimation()
    }
    
    /**
     *  适应
     */
    private func fitScale(imageWidth: CGFloat, imageHeight: CGFloat) {
        var newWidth: CGFloat
        var newHeight: CGFloat
        if imageWidth/imageHeight > self.bounds.width/self.bounds.height {
            newWidth = self.bounds.width
            newHeight = self.frame.size.width/(imageWidth/imageHeight)
        } else {
            newHeight = self.frame.size.height
            newWidth = self.frame.size.height/(imageHeight/imageWidth)
        }
        let point = self.center;
        
        self.lastImageView.frame.size = CGSize(width: newWidth, height: newHeight)
        self.lastImageView.center = point
    }
    
    /**
     *  展示动画
     */
    private func showAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "contents")
        var current: Float = 0
        var timeKeys: Array<NSNumber> = []
        
        for time in timeArr {
            timeKeys.append(NSNumber(value: current/self.totalTime))
            current += time.floatValue
        }
        
        animation.keyTimes = timeKeys
        animation.delegate = self
        animation.values = self.imageArr
        animation.repeatCount = MAXFLOAT
        animation.duration = TimeInterval(totalTime)
        animation.isRemovedOnCompletion = false
        self.lastImageView.layer.add(animation, forKey: "GifView")
    }
    // Delegate 动画结束
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
    }
    
    func setselectimg() {
        self.chooseView.isSelect = true
//        let img = UIImage(named: "photo_sel_photoPicker2", in: BundleUtil.getCurrentBundle(), compatibleWith: nil)?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
//        self.selectBtn.setBackgroundImage(img, for: .normal)
//        self.selectBtn.tintColor = CLPickersTools.instence.tineColor
    }
}

