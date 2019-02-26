//
//  ArrayUtils.swift
//  Ideal-IOS
//
//  Created by darren on 2018/12/4.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit
public extension Array {
    // 去重
    public func id_filterDuplicates<E: Equatable>(_ filter: (Element) -> E) -> [Element] {
        var result = [Element]()
        for value in self {
            let key = filter(value)
            if !result.map({filter($0)}).contains(key) {
                result.append(value)
            }
        }
        return result
    }
}
