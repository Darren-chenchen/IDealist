//
//  PlistUtils.swift
//  Ideal-IOS
//
//  Created by darren on 2018/12/4.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit
//读取Plist文件信息的工具类
public class IDPlistUtils {
    
    public static func get(_ key: String) -> String {
        //防止崩溃
        if Bundle.main.object(forInfoDictionaryKey: key) != nil {
            return Bundle.main.object(forInfoDictionaryKey: key) as! String
        }
        
        return ""
    }
    
    //获取版本号
    public static func getBuildCode() -> String {
        if Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") != nil {
            return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        }
        
        return ""
    }
    
    //获取版本名称
    public static func getVersionCode() -> String {
        if Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") != nil {
            return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        }
        
        return ""
    }
    
}
