//
//  UrlUtils.swift
//  Ideal-IOS
//
//  Created by darren on 2018/12/4.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit
public extension URL {
    // 过滤字符串中的特殊字符
    public static func id_init(string:String) -> URL? {
        let urlStrVaile = string.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        return URL(string: urlStrVaile ?? "")
    }
}
