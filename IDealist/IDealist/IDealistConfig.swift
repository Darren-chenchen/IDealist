//
//      IDealistConfig.swift
//  IDUIKit-ios
//
//  Created by darren on 2018/12/3.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit

public class IDealistConfig: NSObject {
    
    public static let share = IDealistConfig()
    
    // loading展示时间最长为60秒
    public var maxShowInterval: Float = 60
    
    /// switch主题色、progressView主题色、
    public var mainColor: UIColor = UIColor.init(red: 13/255.0, green: 133/255.0, blue: 255/255.0, alpha: 1)
    
    public func id_setupMainColor(color: UIColor) {
        self.mainColor = color
    }
}


