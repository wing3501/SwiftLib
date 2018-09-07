//
//  NSDate-Extension.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/8.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import UIKit

extension Date {
    ///当前时间戳
    static func getCurrentTimeStamp() -> String {
        let nowDate = Date()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
    
    //获取当前时间天数
    static var dayOfToday:String{
        get{
            let formatter = DateFormatter()
            formatter.dateFormat = "dd"
            let date = Date()
            let day = formatter.string(from: date)
            return day
        }
    }
}
