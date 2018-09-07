//
//  Protocol.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/14.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum RxResult {
    case ok(message:String)
    case empty
    case failed(message:String)
}

extension RxResult {
    var isValid:Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}


extension RxResult {
    var textColor:UIColor {
        switch self {
        case .ok:
            return UIColor(red: 138.0 / 255.0, green: 221.0 / 255.0, blue: 109.0 / 255.0, alpha: 1.0)
        case .empty:
            return UIColor.black
        case .failed:
            return UIColor.red
        }
    }
}

extension RxResult {
    var description: String {
        switch self {
        case let .ok(message):
            return message
        case .empty:
            return ""
        case let .failed(message):
            return message
        }
    }
}


extension Reactive where Base:UILabel {
    var validationResult: Binder<RxResult> {
        return Binder(base) {label,result in
            label.textColor = result.textColor
            label.text = result.description
        }
    }
}

extension Reactive where Base:UITextField {
    var inputEnabled: Binder<RxResult> {
        return Binder(base) {textFiled, result in
            textFiled.isEnabled = result.isValid
        }
    }
}


