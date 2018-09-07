//
//  Observable-Extension.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/25.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import Foundation
import RxSwift
import HandyJSON

extension Observable {
    
    /// 把Json信号转换成Model信号
    ///
    /// - Parameter type: 需要转换的Model的类型
    /// - Returns: Model信号
    func mapObject<T :HandyJSON>(type: T.Type) -> Observable<T> {
    
        return self.map { (response) -> T in
            
            guard let dict = response as? [String : Any] else{
                throw RxSwiftMoyaError.ParseJSONError
            }
            
            guard let obj = T.deserialize(from: dict) else{
                throw RxSwiftMoyaError.ParseJSONError
            }
            return obj
        }
    }
    
    func mapArray<T: HandyJSON>(type: T.Type) -> Observable<[T]> {
        return self.map { response in
            
            guard let array = response as? [Any] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            
            guard let objArray = [T].deserialize(from: array) else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            
            return objArray as! [T]
        }
    }
    
    
}

enum RxSwiftMoyaError: String {
    case ParseJSONError
    case OtherError
}
extension RxSwiftMoyaError: Swift.Error { }


