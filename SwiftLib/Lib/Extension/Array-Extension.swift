//
//  Array-Extension.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2018/1/18.
//  Copyright © 2018年 申屠云飞. All rights reserved.
//

import Foundation

extension Array {
    subscript(safe idx:Int) -> Element? {
        return idx < endIndex ? self[idx] : nil
    }
}
