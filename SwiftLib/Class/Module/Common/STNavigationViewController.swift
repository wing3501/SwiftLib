//
//  STNavigationViewController.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/28.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import UIKit

class STNavigationViewController: UINavigationController {

    private static let initialize: () = {
        UINavigationBar.appearance().barTintColor = UIColor(hex: STNavigationBarColor)
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15.0),
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
        UINavigationBar.appearance().isTranslucent = false
    }()
    
    override public init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        STNavigationViewController.initialize
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
