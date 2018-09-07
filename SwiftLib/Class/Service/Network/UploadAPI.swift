//
//  UploadAPI.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/27.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import Foundation
import Moya


public enum UploadAPI {
    case upload(data: Data)
}

extension UploadAPI: TargetType {
    
    public var baseURL: URL {
        return URL(string: "http://xxapi.beeways.cn")!
    }
    
    public var path: String {
        switch self {
        case .upload:
            return "/Public/upload"
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case let .upload(data):
            let gifData = MultipartFormData(provider: .data(data), name: "file", fileName: "iosimage.jpg", mimeType: "image/jpg")
//            let descriptionData = MultipartFormData(provider: .data(description.data(using: .utf8)!), name: "description")
//            let multipartData = [gifData, descriptionData]
            let multipartData = [gifData]
            return .uploadMultipart(multipartData)
        }
    }
    
    public var method: Moya.Method {
        return .post
    }
    
    public var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    public var headers: [String : String]? {
        return [:]
    }
}
