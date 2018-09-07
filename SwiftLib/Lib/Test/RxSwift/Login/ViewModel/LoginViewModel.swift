//
//  LoginViewModel.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/15.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    let usernameUseable:Driver<RxResult>
    let loginButtonEnabled:Driver<Bool>
    let loginResult:Driver<RxResult>
    
    init(input:(username:Driver<String>, password:Driver<String>, loginTaps:Driver<Void>), service:ValidationService) {
        
        usernameUseable = input.username.flatMapLatest { userName in
            return service.loginUserNameValid(userName).asDriver(onErrorJustReturn: .failed(message: "连接server失败"))
        }
        
        let usernameAndPass = Driver.combineLatest(input.username,input.password) {
            return ($0, $1)
        }
        
        loginResult = input.loginTaps.withLatestFrom(usernameAndPass).flatMapLatest{ (username, password)  in
            service.login(username, password: password).asDriver(onErrorJustReturn: .failed(message: "连接server失败"))
        }
        
        loginButtonEnabled = input.password.map {
            $0.count > 0
            }.asDriver()
    }
}
