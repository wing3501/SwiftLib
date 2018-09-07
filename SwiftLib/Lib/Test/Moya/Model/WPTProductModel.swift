//
//  WPTProductModel.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/22.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import Foundation
import HandyJSON

class WPTProductModel: HandyJSON {
    var pid: Int?
    var uri: String?
    var cid: Int?
    var scid: Int?
    var etime: Date?
    var startPrice: Double?
    var dataType: String?
    var abnormalLevel: Int?
    var cover: String?
    var sellerUri: String?
    var sellerAvatar: String?
    var price: Double?
    var time: Date?
    
    required init() {
        
    }
    
    func mapping(mapper: HelpingMapper) {
        // specify 'cat_id' field in json map to 'id' property in object
        mapper <<<
            self.pid <-- "id"
        
        // specify 'parent' field in json parse as following to 'parent' property in object
        mapper <<<
            self.etime <-- TransformOf<Date,TimeInterval>(fromJSON: { (t) -> Date? in
                return Date(timeIntervalSince1970: t!)
            }, toJSON: { (date) -> TimeInterval? in
                return date?.timeIntervalSince1970
            })
        
        
//        mapper <<<
//            self.etime <-- TransformOf<Date, String>(fromJSON: { (rawString) -> Date? in
//                if let parentNames = rawString?.characters.split(separator: "/").map(String.init) {
//                    return (parentNames[0], parentNames[1])
//                }
//                return nil
//            }, toJSON: { Date -> String? in
//                if let _tuple = tuple {
//                    return "\(_tuple.0)/\(_tuple.1)"
//                }
//                return nil
//            })
        // specify 'friend.name' path field in json map to 'friendName' property
//        mapper <<<
//            self.friendName <-- "friend.name"
    }
}
