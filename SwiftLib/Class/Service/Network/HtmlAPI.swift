//
//  HtmlAPI.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/29.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import Foundation
import Moya

public enum HtmlAPI {
    case movielist1
    case movielist2
    case movielist3
}

extension HtmlAPI: TargetType {
    public var baseURL: URL {
//        return URL(string: "http://games.tgbus.com/")!

    }
    
    public var path: String {
        switch self {
        case .movielist1:
            return "movielist1"
        case .movielist2:
            return "movielist2"
        case .movielist3:
            return "movielist3"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    public var task: Moya.Task {
        return .requestPlain
    }
    
    public var headers: [String : String]? {
        return [:]
    }
}
