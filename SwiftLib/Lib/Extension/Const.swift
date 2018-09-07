//
//  Const.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/8.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import UIKit

let kScreenW = UIScreen.main.bounds.width
let kScreenH = UIScreen.main.bounds.height
let kScreenBounds = UIScreen.main.bounds
let kWindow = UIApplication.shared.keyWindow

let kNavigationBarH : CGFloat = 44
let kStatusBarH : CGFloat = 20


func asyncExecuteOnMain(_ block:@escaping ()->Void){
    if Thread.isMainThread{
        block()
    }else{
        DispatchQueue.main.async {
            block()
        }
    }
}

func syncExecuteOnMain(_ block:@escaping ()->Void){
    if Thread.isMainThread{
        block()
    }else{
        DispatchQueue.main.sync {
            block()
        }
    }
}

func log(condition: Bool,
         message: @autoclosure () -> (String),
         file: String = #file, line function: String = #function, line: Int = #line) {
    if condition { return }
    print("\(message()), \(file):\(function) (line \(line))")
}
