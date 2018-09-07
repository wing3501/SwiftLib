//
//  Network.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/27.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxCocoa

struct Network {

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
    
    
    static let bag: DisposeBag = DisposeBag()
    static let provider = MoyaProvider<MultiTarget>()
    
    static func request(
        target:MultiTarget,
        success successCallback: ((_ baseModel: WPTBaseModel) -> Void)? = nil,
        error errorCallback: ((_ error: Error) -> Void)? = nil
        ) {
        
        provider.rx.request(target).mapJSON().asObservable().mapObject(type: WPTBaseModel.self).subscribe { (event) in
            switch event {
            case .next(let baseModel):
                if(baseModel.code == 0) {
                    if let success = successCallback {
                        success(baseModel)
                    }
                }else{
                    if let error = errorCallback {
                        error(NetworkError(baseModel.code!))  //自定义错误
                    }
                }
            case .error(let e):
                if let error = errorCallback {
                    error(e)
                }
            case .completed:
                print("completed")
            }
        }.disposed(by: bag)
        
//        WPTAPIProvider.rx.request(.guangguang).mapJSON().asObservable().mapObject(type: WPTBaseModel.self).subscribe(onNext: { (baseModel) in
//            let tempArray = baseModel.data?["list"] as? NSArray
//            if let array = [WPTProductModel].deserialize(from: tempArray) {
//
//            }
//        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: bag)
    }
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
}

struct NetworkError: Error {
    var errorCode: Int
    var msg: String = ""
    init(_ errorCode: Int) {
        self.errorCode = errorCode
    }
    
    init(_ errorCode: Int,_ msg: String) {
        self.init(errorCode)
        self.msg = msg
    }
}


//// usage:
//Network.request(.zen, success: { zen in
//    showMessage(zen)
//}, error: { err in
//    showError(err)
//}, failure: { _ in
//    // oh well, no network apparently
//})


