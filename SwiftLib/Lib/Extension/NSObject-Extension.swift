//
//  NSObject-Extension.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/18.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import Foundation

extension NSObject {
    //打印内存地址
    func nsObjectAddr(_ obj: NSObject?) {
        guard let o = obj else{
            nsObjectAddr()
            return
        }
        print(("\(type(of: o)) ------>\(Unmanaged.passUnretained(o).toOpaque())"))
    }
    
    func nsObjectAddr() {
        print(("\(type(of: self)) ------>\(Unmanaged.passUnretained(self).toOpaque())"))
    }
    
}
