//
//  Service.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/14.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import Foundation
import RxSwift

class ValidationService {
    static let instance = ValidationService()
    
    let minCharactersCount = 6
    
    let filePath = NSHomeDirectory() + "/Documents/users.plist"
    
    init() {
        
    }
    
    func validationUserName(_ name:String) -> Observable<RxResult> {
        
        if name.count == 0 { // 当字符串为空的时候，什么也不做
            return Observable.just(RxResult.empty)
        }
        
        if name.count < minCharactersCount {
            return Observable.just(RxResult.failed(message: "用户名长度至少为6位"))
        }
        
        if checkHasUserName(name) {
            return Observable.just(RxResult.failed(message: "用户名已存在"))
        }
        
        return Observable.just(RxResult.ok(message: "用户名可用"))
    }
    
    
    func checkHasUserName(_ userName:String) -> Bool {
        
        guard let userDict = NSDictionary(contentsOfFile: filePath) else {
            return false
        }
        
        let usernameArray = userDict.allKeys as NSArray
        
        return usernameArray.contains(userName)
    }
    
    
    func validationPassword(_ password:String) -> RxResult {
        if password.count == 0 {
            return RxResult.empty
        }
        
        if password.count < minCharactersCount {
            return .failed(message: "密码长度至少为6位")
        }
        
        return .ok(message: "密码可用")
    }
    
    func validationRePassword(_ password:String, _ rePassword: String) -> RxResult {
        if rePassword.count == 0 {
            return .empty
        }
        
        if rePassword.count < minCharactersCount {
            return .failed(message: "密码长度至少为6位")
        }
        
        if rePassword == password {
            return .ok(message: "密码可用")
        }
        
        return .failed(message: "两次密码不一样")
    }
    
    
    func register(_ username:String, password:String) -> Observable<RxResult> {
        let userDict = [username: password]
        
        if (userDict as NSDictionary).write(toFile: filePath, atomically: true) {
            return Observable.just(RxResult.ok(message: "注册成功"))
        }else{
            return Observable.just(RxResult.failed(message: "注册失败"))
        }
    }
    
    
    
    
    
    
    
    
    // MARK:- 登录
    
    func loginUserNameValid(_ userName:String) -> Observable<RxResult> {
        if userName.count == 0 {
            return Observable.just(RxResult.empty)
        }
        
        if checkHasUserName(userName) {
            return Observable.just(RxResult.ok(message: "用户名可用"))
        }
        
        return Observable.just(RxResult.failed(message: "用户名不存在"))
    }
    
    // 登录
    func login(_ username:String, password:String) -> Observable<RxResult> {
        
        guard let userDict = NSDictionary(contentsOfFile: filePath),
            let userPass = userDict.object(forKey: username)
            else {
                return Observable.just(RxResult.empty)
        }
        
        if (userPass as! String) == password {
            return Observable.just(RxResult.ok(message: "登录成功"))
        }else{
            return Observable.just(RxResult.failed(message: "密码错误"))
        }
    }
}


// MARK:- 列表

class SearchService {

    
    static let instance = SearchService();
    private init(){}
    
    // 获取联系人
    func getContacts() -> Observable<[Contact]> {
        let contactPath = Bundle.main.path(forResource: "Contact", ofType: "plist")
        let contactArr = NSArray(contentsOfFile: contactPath!) as! Array<[String:String]>
        
        
        var contacts = [Contact]()
        for contactDict in contactArr {
            let contact = Contact(name:contactDict["name"]!, phone: contactDict["phone"]!)
            contacts.append(contact)
        }
        
        return Observable.just(contacts).observeOn(MainScheduler.instance)
    }
    
    func getContacts(withName name: String) -> Observable<[Contact]> {
        if name == "" {
            return getContacts()
        }
        
        let contactPath = Bundle.main.path(forResource: "Contact", ofType: "plist")
        let contactArr = NSArray(contentsOfFile: contactPath!) as! Array<[String:String]>
        
        var contacts = [Contact]()
        for contactDict in contactArr {
            if contactDict["name"]!.contains(name) {
                let contact = Contact(name:contactDict["name"]!, phone: contactDict["phone"]!)
                contacts.append(contact)
            }
        }
        
        return Observable.just(contacts).observeOn(MainScheduler.instance)
    }
    
}
