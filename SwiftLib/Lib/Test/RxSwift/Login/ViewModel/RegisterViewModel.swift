//
//  RegisterViewModel.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/14.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import Foundation
import RxSwift

class RegisterViewModel {
    let username = Variable<String>("")
    let password = Variable<String>("")
    let rePassword = Variable<String>("")
    
    let usernameUseable:Observable<RxResult>
    let passwordUseable:Observable<RxResult>
    let rePasswordUseable:Observable<RxResult>
    
    
    let registerTaps = PublishSubject<Void>()
    
    let registerButtonEnabled:Observable<Bool>
    let registerResult:Observable<RxResult>

    
    init() {
        let service = ValidationService.instance
        
        usernameUseable = username.asObservable().flatMapLatest{ username in
            return service.validationUserName(username).observeOn(MainScheduler.instance).catchErrorJustReturn(.failed(message: "userName检测出错"))
        }.share(replay: 1)
        
        passwordUseable = password.asObservable().map { passWord in
            return service.validationPassword(passWord)
            }.share(replay: 1)
        
        rePasswordUseable = Observable.combineLatest(password.asObservable(), rePassword.asObservable()) {
            return service.validationRePassword($0, $1)
            }.share(replay: 1)
        
        
        registerButtonEnabled = Observable.combineLatest(usernameUseable, passwordUseable, rePasswordUseable) { (username, password, repassword) in
            return username.isValid && password.isValid && repassword.isValid
            }.distinctUntilChanged().share(replay: 1)
        
        let usernameAndPwd = Observable.combineLatest(username.asObservable(), password.asObservable()){
            return ($0, $1)
        }
        
        registerResult = registerTaps.asObservable().withLatestFrom(usernameAndPwd).flatMapLatest { (username, password) in
            return service.register(username, password: password).observeOn(MainScheduler.instance).catchErrorJustReturn(RxResult.failed(message: "注册失败"))
            }.share(replay: 1)
        

    }
}
