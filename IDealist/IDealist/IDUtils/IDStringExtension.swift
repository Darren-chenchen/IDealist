//
//  StringUtils.swift
//  Ideal-IOS
//
//  Created by darren on 2018/12/4.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit
public extension String {
    /// 字符串截取函数
    public func id_subString(to index: Int) -> String {
        if index >= self.count {
            return String(self[..<self.index(self.startIndex, offsetBy: self.count)])
        }
        return String(self[..<self.index(self.startIndex, offsetBy: index)])
    }
    /// 字符串截取函数
    public func id_subString(from index: Int) -> String {
        if index >= self.count {
            return String(self[self.index(self.startIndex, offsetBy: self.count)...])
        }
        return String(self[self.index(self.startIndex, offsetBy: index)...])
    }
    
    public func id_subString(from index: Int, offSet: Int) -> String {
        let begin = self.id_subString(from: index)
        let str = begin.id_subString(to: offSet)
        return str
    }
    
    /// range转换为NSRange
    public func id_range(from range: Range<String.Index>) -> NSRange? {
        let utf16view = self.utf16
        if let from = range.lowerBound.samePosition(in: utf16view), let to = range.upperBound.samePosition(in: utf16view) {
            return NSMakeRange(utf16view.distance(from: utf16view.startIndex, to: from), utf16view.distance(from: from, to: to))
        }
        return nil
    }
    
}
