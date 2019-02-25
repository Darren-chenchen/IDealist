//
//  TestIDImagePickerViewController.swift
//  IdealDemo
//
//  Created by darren on 2018/12/8.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit
   
class TestIDImagePickerViewController: IDBaseViewController {

    let picker = IDImagePicker()
    let picker2 = IDImagePicker()
    let picker3 = IDImagePicker()
    let picker4 = IDImagePicker()
    let picker5 = IDImagePicker()
    
    lazy var photoView: PhotoView = {
        let photo = PhotoView.init(frame: CGRect.init(x: 0, y: 200, width: KScreenWidth, height: 80))
        photo.backgroundColor = UIColor.groupTableViewBackground
        return photo
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.id_navTitle = "IDImagePicker"
        
        let titleArr = ["访问相册，外部弹出", "访问相册，默认多选", "访问相册，单选", "高度定制导航栏颜色", "高度定制主题色"]
        let colorArr = [UIColor.red, UIColor.brown, UIColor.purple, UIColor.orange, UIColor.magenta]
        
        for i in 0..<titleArr.count {
            let y: CGFloat = CGFloat(90 + i * (40+30))
            let btn = UIButton.init(frame: CGRect.init(x: 30, y: y, width: KScreenWidth-60, height: 40))
            btn.setTitle(titleArr[i], for: UIControl.State.normal)
            btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
            btn.backgroundColor = colorArr[i]
            btn.tag = 100 + i
            btn.id_border(0, UIColor.clear, 20)
            btn.addTarget(self, action: #selector(clickBtn(btn:)), for: UIControl.Event.touchUpInside)
            self.view.addSubview(btn)
        }
        
        self.photoView.id_y = CGFloat(60 + titleArr.count * (40+30)) + 50
        self.view.addSubview(self.photoView)
        
        // 先拼接一个图片
        self.photoView.picArr.append(UIImage(named: "takePicture")!)
        // 点击了删除，更新界面
        self.photoView.closeBtnClickClouse = {[weak self] (imageArr) in
            self?.photoView.picArr = imageArr
        }
        // 访问相册,完成后将asset对象通过异步的方式转换为image对象，图片较清晰
        self.photoView.visitPhotoBtnClickClouse = {[weak self] () in
            self?.setupPhoto1()
        }
    }
    
    // 异步原图
    private func setupPhoto1() {
        let imagePickTool = IDImagePicker()
        imagePickTool.id_setupImagePickerWith(maxImagesCount: 10) { (assetArr,cutImage) in
            print("返回的asset数组是\(assetArr)")
            
            IDLoading.id_show()
            
            self.photoView.picArr.removeAll()
            self.photoView.picArr.append(UIImage(named: "takePicture")!)
            
            var imageArr = [UIImage]()
            var index = assetArr.count // 标记失败的次数
            
            // 获取原图，异步
            // scale 指定压缩比
            // 内部提供的方法可以异步获取图片，同步获取的话时间比较长，不建议！，如果是iCloud中的照片就直接从icloud中下载，下载完成后返回图片,同时也提供了下载失败的方法
            IDImagePicker.convertAssetArrToOriginImage(assetArr: assetArr, scale: 0.1, successClouse: {[weak self] (image,assetItem) in
                imageArr.append(image)
                self?.photoView.picArr.append(image)
                
                self?.dealImage(imageArr: imageArr, index: index)
                
                }, failedClouse: { () in
                    index = index - 1
                    self.dealImage(imageArr: imageArr, index: index)
            })
        }
    }
    @objc func dealImage(imageArr:[UIImage],index:Int) {
        // 图片下载完成后再去掉我们的转转转控件，这里没有考虑assetArr中含有视频文件的情况
        if imageArr.count == index {
            IDLoading.id_dismiss()
        }
        // 图片显示出来以后可能还要上传到云端的服务器获取图片的url，这里不再细说了。
    }
    
    
    @objc func clickBtn(btn: UIButton) {
        if btn.tag == 100 {
            picker.cameraOut = true
            picker.id_setupImagePickerWith(maxImagesCount: 10) { (assrtArr, img) in
            }
        }
        if btn.tag == 101 {
            picker2.id_setupImagePickerWith(maxImagesCount: 10) { (assrtArr, img) in
            }
        }
        if btn.tag == 102 {
            picker3.singleImageChooseType = .singlePicture
            picker3.id_setupImagePickerWith(maxImagesCount: 10) { (assrtArr, img) in
            }
        }
        if btn.tag == 103 {
            picker4.navColor = UIColor.purple
            picker4.navTitleColor = UIColor.white
            picker4.statusBarType = .white
            picker4.id_setupImagePickerWith(maxImagesCount: 10) { (assrtArr, img) in
            }
        }
        if btn.tag == 104 {
            picker5.tineColor = UIColor.green
            picker5.id_setupImagePickerWith(maxImagesCount: 10) { (assrtArr, img) in
            }
        }
    }
    
}

