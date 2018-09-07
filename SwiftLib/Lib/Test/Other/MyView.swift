//
//  MyView.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/8.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import UIKit

class MyView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
