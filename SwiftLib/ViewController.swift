//
//  ViewController.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/8.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import UIKit
import Result
import HandyJSON
import Alamofire
import DrawerController

enum JSONError: Error {
    case noSuchKey(String)
    case typeMismatch
}

class ViewController: UIViewController {

    let manager = NetworkReachabilityManager(host: "www.baidu.com")
    fileprivate lazy var snowView: SnowView = {
       let v = SnowView(frame: kScreenBounds)
        v.load(URLRequest(url: URL(string: "https://huodong.m.taobao.com/act/christmas2017ios.html?spm=a1z8m.7980655&ttid=700407@taobao_iphone_7.2.1")!))
        v.backgroundColor = UIColor.clear
        v.isOpaque = false
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("\(Date.getCurrentTimeStamp())")
        
//        printAddr(self)
//        printAddr()
        
//        let a:Result<String,JSONError> = .success("value")
        
        testHandyJSON2()
        
        
        manager?.listener = { status in
            print("Network Status Changed: \(status)")
        }
        
        manager?.startListening()
        

        
    }
    
    
    
    func testHandyJSON() {
        let json = "{\"username\":\"styf\",\"age\":28,\"books\":[{\"name\":\"第一本书\",\"price\":0.01},{\"name\":\"第二本书\",\"price\":0.02}],\"dog\":{\"name\":\"来福\",\"age\":5},\"bookDic\":{\"第一个字段\":\"哈哈\",\"第二个字段\":100},\"birthday\":\"2017-11-11\"}"
        
        if let p = Persion.deserialize(from: json) {
            print("=====>\(p)")
        }
    }
    
    
    func testHandyJSON2() {
        let json = ""
        
        if let p = WPTBaseModel.deserialize(from: json) {
//            print("=====>\(String(describing: p.data))")
//            if let array = p.data!["list"] {
//                print("=====>\(array)")
//                print("=====>\(String(describing: array))")
//            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func go(_ sender: Any) {
        let nav = BaseNavigationController(rootViewController: OneViewController())
        present(nav, animated: true, completion: nil)
    }
    
    @IBAction func GPUImageTest(_ sender: Any) {
        let vc = GPUImageViewController(nibName:nil, bundle: nil);
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func rxSwift(_ sender: Any) {
        let vc = RxSwiftViewController(nibName:nil, bundle: nil);
        present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func RxLoginTest(_ sender: Any) {
        let vc = RxRegisterViewController(nibName: nil, bundle: nil)
        vc.title = "登录"
        let nav = UINavigationController(rootViewController: vc);
        
        present(nav, animated: true, completion: nil)
        
    }
    
    
    @IBAction func moya(_ sender: Any) {
        let vc = MoyaViewController(nibName:nil, bundle: nil);
        let nav = UINavigationController(rootViewController: vc);
        present(nav, animated: true, completion: nil)
    }
    
    
    @IBAction func xiangmu(_ sender: Any) {
        let mainVC = STMainViewController()
        let leftVC = STLeftViewController(nibName: nil, bundle: nil)
        
        let mainNavVC = STNavigationViewController(rootViewController: mainVC)
        
        let drawVC = STDrawerController(centerViewController: mainNavVC, leftDrawerViewController: leftVC, rightDrawerViewController: nil)
        
        drawVC.showsShadows = false
        drawVC.restorationIdentifier = "Drawer"
        drawVC.maximumLeftDrawerWidth = 240.0
        drawVC.openDrawerGestureModeMask = .all
        drawVC.closeDrawerGestureModeMask = .all
        drawVC.drawerVisualStateBlock = DrawerVisualState.parallaxVisualStateBlock(parallaxFactor: 2.0)

        present(drawVC, animated: true, completion: nil)
    }
    
    
    override var shouldAutorotate: Bool {
        get {
            return false
        }
        set {
            self.shouldAutorotate = newValue
        }
    }
    @IBAction func snow(_ sender: Any) {
        view.addSubview(snowView)
    }
    
    
    
}




