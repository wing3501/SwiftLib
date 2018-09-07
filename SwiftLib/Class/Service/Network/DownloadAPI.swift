//
//  DownloadAPI.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/27.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import Foundation
import Moya

fileprivate let downloadDir: URL = {
    let directoryURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return directoryURLs.first ?? URL(fileURLWithPath: NSTemporaryDirectory())
}()


//let DownloadAPIProvider = MoyaProvider<DownloadAPI>()

public enum DownloadAPI {
    case download(fileUrl: String)
}

extension DownloadAPI: TargetType {
    
    public var baseURL: URL {
        return URL(string: "http://img1.gamersky.com")!
    }
    
    public var path: String {
        switch self {
        case let .download(fileUrl):
            return fileUrl
        }
    }
        
    var fileName: String {
        switch self {
        case let .download(fileUrl):
            return (fileUrl as NSString).lastPathComponent
        }
    }
    
    public var localLocation: URL {
        return downloadDir.appendingPathComponent(fileName)
    }
    
    var downloadDestination: DownloadDestination {
        return { _, _ in return (self.localLocation, .removePreviousFile) }
    }
    
    public var task: Moya.Task {
        switch self {
        case .download:
            return .downloadDestination(downloadDestination)
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    public var headers: [String : String]? {
        return [:]
    }
}
