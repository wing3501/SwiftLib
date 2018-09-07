//
//  NSString-Extension.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/25.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import UIKit

extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
    
    func isUrl() -> Bool {
        if self.count == 0 {
            return false
        }else{
            var url = self
            if (url as NSString).length > 4 && (url as NSString).substring(to: 4) == "www." {
                url = "http://" + url
            }
            let urlRegex = "(https|http|ftp|rtsp|igmp|file|rtspt|rtspu)://((((25[0-5]|2[0-4]\\d|1?\\d?\\d)\\.){3}(25[0-5]|2[0-4]\\d|1?\\d?\\d))|([0-9a-z_!~*'()-]*\\.?))([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\\.([a-z]{2,6})(:[0-9]{1,4})?([a-zA-Z/?_=]*)\\.\\w{1,5}"
            //(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]
            
            let predicate = NSPredicate(format: "SELF MATCHES %@", urlRegex)
            return predicate.evaluate(with:url)
        }
    }
}
