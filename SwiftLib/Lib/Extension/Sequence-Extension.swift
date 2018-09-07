//
//  Sequence-Extension.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2018/1/11.
//  Copyright © 2018年 申屠云飞. All rights reserved.
//

import Foundation

extension Sequence {
    ///序列中所有元素是否都满足某个条件
    public func all(matching predicate: (Iterator.Element) -> Bool) -> Bool {
        // 对于一个条件，如果没有元素不满足它的话，那意味着所有元素都满足它:
        return !contains { !predicate($0) } }
}


extension Sequence where Iterator.Element: Hashable {
    ///序列元素去重
    func unique() -> [Iterator.Element] {
    var seen: Set<Iterator.Element> = []
        return filter({
            if seen.contains($0) {
                return false
            }else{
                seen.insert($0)
                return true
            }
        })
    }
}
