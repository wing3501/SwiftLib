//
//  WPTBaseModel.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/22.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import Foundation
import HandyJSON

class WPTBaseModel: HandyJSON{
    var code: Int?
    var msg: String?
    var data: [String:Any]?
    
    required init() {
        
    }
}
