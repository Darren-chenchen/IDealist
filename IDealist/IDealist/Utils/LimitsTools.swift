//
//  LimitsTools.swift
//  CloudscmSwift
//
//  Created by DENG on 2018/8/28.
//  Copyright © 2018年 Heading. All rights reserved.
//

//MARK: - 判断相机相册权限的工具类

import UIKit
import AVFoundation
import PhotosUI

class LimitsTools: NSObject {
    
   static let share = LimitsTools()

    // 判断是否开启相机权限
    func authorizeCamera(authorizeClouse:@escaping (AVAuthorizationStatus)->()){
        let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        // 判断当前权限
        if status == .authorized{
            // 当前为"允许"
            authorizeClouse(status)
        } else if status == .notDetermined {
            // 当前为"尚未授权"，请求授权
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted) in
                if granted {
                    authorizeClouse(.authorized)
                } else {
                    authorizeClouse(.denied)
                    // 相机未授权弹框
                    self.showCameraAlert()
                }
            })
        } else {
            // 当前为"不允许"
            authorizeClouse(status)
            // 相机未授权弹框
            self.showCameraAlert()
        }
    }
    
    // 判断是否开启相册权限
    func authorizePhotoLibrary(authorizeClouse:@escaping (PHAuthorizationStatus)->()){
        let status = PHPhotoLibrary.authorizationStatus()
        // 判断当前权限
        if status == .authorized{
            // 当前为"允许"
            authorizeClouse(status)
        } else if status == .notDetermined {
            // 当前为"尚未授权"，请求授权
            PHPhotoLibrary.requestAuthorization({ (state) in
                if state == PHAuthorizationStatus.authorized {
                    authorizeClouse(.authorized)
                } else {
                    authorizeClouse(.denied)
                    // 相册未授权弹框
                    self.showLibraryAlert()
                }
            })
        } else {
            // 当前为"不允许"
            authorizeClouse(status)
            // 相册未授权弹框
            self.showLibraryAlert()
        }
    }
    
    
    // 相机未授权弹框
    func showCameraAlert() {
        let cameraLimitStr = "相机访问受限"
        let clickCameraStr = "点击“设置”，允许访问您的相机"
        
        IDDialog.id_show(title: cameraLimitStr, msg: clickCameraStr, leftActionTitle: "取消", rightActionTitle: "设置", leftHandler: {
            
        }) {
            // 跳转到权限系统设置界面
            self.toSettingVC()
        }
    }
    
    // 相册未授权弹框
    func showLibraryAlert() {
        let libraryLimitStr = "相册访问受限"
        let clickLibraryStr = "点击“设置”，允许访问您的相册"
        
        IDDialog.id_show(title: libraryLimitStr, msg: clickLibraryStr, leftActionTitle: "取消", rightActionTitle: "设置", leftHandler: {
            
        }) {
            // 跳转到权限系统设置界面
            self.toSettingVC()
        }
    }
    
    // 跳转到权限系统设置界面
    func toSettingVC() {
        let url = URL(string: UIApplication.openSettingsURLString)
        if let url = url, UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:],
                                          completionHandler: {
                                            (success) in
                })
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    

}
