//
//  STDrawerController.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2018/1/4.
//  Copyright © 2018年 申屠云飞. All rights reserved.
//

import UIKit
import DrawerController

class STDrawerController: DrawerController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var shouldAutorotate: Bool {
        get {
            return false
        }
        set {
            self.shouldAutorotate = newValue
        }
    }

}
