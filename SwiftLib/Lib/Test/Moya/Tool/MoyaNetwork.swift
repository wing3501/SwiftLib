//
//  MoyaNetwork.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/25.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import Foundation
import Moya

//struct Network {

//    let failureEndpointClosure = { (target: MyService) -> Endpoint<MyService> in
//        let sampleResponseClosure = { () -> (EndpointSampleResponse) in
//            if shouldTimeout {
//                return .networkError(NSError())
//            } else {
//                return .networkResponse(200, target.sampleData)
//            }
//        }
//        return Endpoint<MyService>(url: url(target), sampleResponseClosure: sampleResponseClosure, method: target.method, task: target.task)
//    }
    
    
//    static let provider = MoyaProvider<WPTAPI>(endpointClosure: endpointClosure)
//
//    static func request(
//        target: WPTAPI,
//        success successCallback: (JSON) -> Void,
//        error errorCallback: (statusCode: Int) -> Void,
//        failure failureCallback: (MoyaError) -> Void
//        ) {
//        provider.request(target) { result in
//            switch result {
//            case let .success(response):
//                do {
//                    try response.filterSuccessfulStatusCodes()
//                    let json = try JSON(response.mapJSON())
//                    successCallback(json)
//                }
//                catch error {
//                    errorCallback(error)
//                }
//            case let .failure(error):
//                if target.shouldRetry {
//                    retryWhenReachable(target, successCallback, errorCallback, failureCallback)
//                }
//                else {
//                    failureCallback(error)
//                }
//            }
//        }
//    }
//}


//// usage:
//Network.request(.zen, success: { zen in
//    showMessage(zen)
//}, error: { err in
//    showError(err)
//}, failure: { _ in
//    // oh well, no network apparently
//})

