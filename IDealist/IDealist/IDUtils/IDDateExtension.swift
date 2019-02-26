//
//  DateUtils.swift
//  Ideal-IOS
//
//  Created by darren on 2018/12/4.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import Foundation
//MARK: - Date
public extension Date {
    
    fileprivate var string: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        return formatter.string(from: self)
    }
    
    public func format(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    public var start: Date {
        let startString = self.format("yyyy/MM/dd").appending(" 00:00:00")
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return formatter.date(from: startString) ?? self
    }
    
    public var end: Date {
        let endString = self.format("yyyy/MM/dd").appending(" 23:59:59")
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return formatter.date(from: endString) ?? self
    }
    
    var yearMonthDay: String {
        return string.id_subString(to: 10)
    }
    
    /// 是否是今年
    public func id_isThisYear() -> Bool {
        let calendar = NSCalendar.current
        let nowYear = calendar.component(.year, from: Date())
        let selfYear = calendar.component(.year, from: self)
        return nowYear == selfYear
    }
    
    /// 是否是今天
    public func id_isToday() -> Bool {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        let nowString = fmt.string(from: Date())
        let selfString = fmt.string(from: self)
        return nowString == selfString
    }
    
    /// 是否是昨天
    public func id_isYesterday() -> Bool{
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        
        let nowDate = fmt.date(from: fmt.string(from: Date()))
        let selfDate = fmt.date(from: fmt.string(from: self))
        
        let calendar = NSCalendar.current
        let cmps = calendar.dateComponents([.day,.month,.year], from: selfDate!, to: nowDate!)
        
        return cmps.year == 0 && cmps.month == 0 && cmps.day == 1
    }
    
    /// 是否是n天内
    public func id_isBetween(dateNum: Int) -> Bool {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let nowDate = fmt.date(from: fmt.string(from: Date()))
        let selfDate = fmt.date(from: fmt.string(from: self))
        
        let calendar = NSCalendar.current
        let cmps = calendar.dateComponents([.day,.month,.year], from: selfDate!, to: nowDate!)
        
        return cmps.year! == 0 && cmps.month! == 0 && cmps.day! < dateNum
    }
    
    /// 返回几天
    public func id_numberOfDate() -> Int{
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let nowDate = fmt.date(from: fmt.string(from: Date()))
        let selfDate = fmt.date(from: fmt.string(from: self))
        
        let calendar = NSCalendar.current
        let cmps = calendar.dateComponents([.day,.month,.year], from: selfDate!, to: nowDate!)
        
        return cmps.day!
    }
    
    func deltaFrom(fromData: Date) -> DateComponents{
        let calendar = Calendar.current
        //比较时间
        let unitFlags = Set<Calendar.Component>([.hour, .year, .minute, .second, .month, .day])
        let cmps = calendar.dateComponents(unitFlags, from: fromData, to: self)
        return cmps
    }
}
