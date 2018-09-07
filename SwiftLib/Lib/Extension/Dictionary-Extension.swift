//
//  Dictionary-Extension.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2018/1/12.
//  Copyright © 2018年 申屠云飞. All rights reserved.
//

import Foundation
extension Dictionary {
    
    ///从一个键值对序列创建字典
    init<S: Sequence>(_ sequence: S)
        where S.Iterator.Element == (key: Key, value: Value) {
            self = [:]
            self.merge(sequence)
    }
    
    
    /// 将一个字典或键值对数组合并到原字典
    mutating func merge<S>(_ other: S)
        where S: Sequence, S.Iterator.Element == (key: Key, value: Value) {
            for (k, v) in other {
            self[k] = v
        }
    }
}
