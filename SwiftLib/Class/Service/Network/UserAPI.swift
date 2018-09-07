//
//  UserAPI.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/27.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import Foundation
import Moya

public enum UserAPI {
    case login(username: String,password: String)
    case updateUser(id: Int,name: String)
}

extension UserAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "")!
    }
    
    public var path: String {
        switch self {
        case .login:
            return "/discovery/get-data"
        case .updateUser:
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
        case let .login(username,password):
            //            return .requestPlain
            var params: [String:Any] = [:]
            params["username"] = username
            params["password"] = password
            return .requestParameters(parameters: params, encoding: URLEncoding.httpBody)
        case let .updateUser(id):
            var params: [String:Any] = [:]
            params["id"] = id
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
