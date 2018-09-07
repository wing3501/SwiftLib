//
//  MyAPI.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/27.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import Foundation
import Moya

public enum MyAPI {
    case myPage
    case myAccount(id: Int)
}

extension MyAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "")!
    }
    
    public var path: String {
        switch self {
        case .myPage:
            return "/discovery/get-data"
        case .myAccount:
            return "/discovery/get-data"
        }
    }
    
    public var method: Moya.Method {
        return .post
    }
    
    public var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    public var task: Moya.Task {
        switch self {
        case .myPage:
            //            return .requestPlain
            var params: [String:Any] = [:]
            params["aaAAAAAAAAAAAAAAAAAA"] = 1
            return .requestParameters(parameters: params, encoding: URLEncoding.httpBody)
        case let .myAccount(id):
            return .requestParameters(parameters: ["id": id], encoding: JSONEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
