//
//  Person.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/22.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import Foundation
import HandyJSON

class Persion: HandyJSON{
    var username: String?
    var age: Int?
    var books: [Book]?
    var dog: Dog?
    var bookDic: [String:Any]?
    var birthday: Date?
    
    required init() {
        
    }
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            birthday <-- CustomDateFormatTransform(formatString: "yyyy-MM-dd")
        
        //            mapper <<<
        //                decimal <-- NSDecimalNumberTransform()
        //
        //            mapper <<<
        //                url <-- URLTransform(shouldEncodeURLString: false)
        //
        //            mapper <<<
        //                data <-- DataTransform()
        //
        //            mapper <<<
        //                color <-- HexColorTransform()
    }
}
