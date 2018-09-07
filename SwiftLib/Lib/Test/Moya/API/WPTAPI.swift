//
//  WPTAPI.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/22.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import Foundation
import Moya


private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}

private func JSONRequestDataFormatter(_ data:Data) -> String {
    
    guard let json = String(data: data, encoding: .utf8) else {
        return ""
    }
    return json
}

let WPTAPIProvider = MoyaProvider<WPTAPI>(plugins: [NetworkLoggerPlugin(verbose: true,requestDataFormatter: JSONRequestDataFormatter, responseDataFormatter: JSONResponseDataFormatter),NetworkActivityPlugin(networkActivityClosure: {(change, target) in
    
    switch (change) {
    case .began:
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    case .ended:
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
})])


public enum WPTAPI {
    case guangguang
    //测试
    case libao
    case showUser(id: Int)
    case createUser(firstName: String, lastName: String)
    case updateUser(id: Int, firstName: String, lastName: String)
    case uploadGif(Data, description: String)
}

extension WPTAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "")!
    }
    
    public var path: String {
        switch self {
        case .guangguang:
            return "/discovery/get-data"
            //测试
        case .libao:
            return "/giftpack/receive-gift-pack"
        case .showUser(let id), .updateUser(let id, _, _):
            return "/users/\(id)"
        case .createUser(_, _):
            return "/users"
        case .uploadGif(_, _):
            return "/upload"
        }
    }
    
    public var method: Moya.Method {
        return .post
    }
    
    public var sampleData: Data {
        switch self {
        case .guangguang:
            return "测试数据".data(using: String.Encoding.utf8)!
        case .libao:
            return "测试数据".data(using: String.Encoding.utf8)!
            
        case .showUser(let id):
            return "{\"id\": \(id), \"first_name\": \"Harry\", \"last_name\": \"Potter\"}".utf8Encoded
        case .createUser(let firstName, let lastName):
            return "{\"id\": 100, \"first_name\": \"\(firstName)\", \"last_name\": \"\(lastName)\"}".utf8Encoded
        case .updateUser(let id, let firstName, let lastName):
            return "{\"id\": \(id), \"first_name\": \"\(firstName)\", \"last_name\": \"\(lastName)\"}".utf8Encoded
        case .uploadGif(_, let description):
            return "测试数据\(description)".data(using: String.Encoding.utf8)!
        }
        
    }
    
    public var task: Moya.Task {
//        return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        
        switch self {
        case .guangguang, .libao: // Send no parameters
//            return .requestPlain
            var params: [String:Any] = [:]
            params["aaAAAAAAAAAAAAAAAAAA"] = 1
            return .requestParameters(parameters: params, encoding: URLEncoding.httpBody)
            
        case let .updateUser(_, firstName, lastName):  // Always sends parameters in URL, regardless of which HTTP method is used
            //这样写，参数为nil时会移除这个参数，推荐
//            var params: [String:Any] = [:]
//            params["first_name"] = firstName
//            params["last_name"] = lastName
            
            return .requestParameters(parameters: ["first_name": firstName, "last_name": lastName], encoding: URLEncoding.queryString)
        case let .createUser(firstName, lastName): // Always send parameters as JSON in request body
            return .requestParameters(parameters: ["first_name": firstName, "last_name": lastName], encoding: JSONEncoding.default)
        case let .showUser(id):
            return .requestParameters(parameters: ["id": id], encoding: JSONEncoding.default)
        case let .uploadGif(data, description):
            let gifData = MultipartFormData(provider: .data(data), name: "file", fileName: "gif.gif", mimeType: "image/gif")
            let descriptionData = MultipartFormData(provider: .data(description.data(using: .utf8)!), name: "description")
            let multipartData = [gifData, descriptionData]
            
            return .uploadMultipart(multipartData)
            
            //如果这个description这个附加参数要加在url上
//            return .uploadCompositeMultipart(multipartData, urlParameters: urlParameters)
        }
        
    }
    
    public var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    
}
