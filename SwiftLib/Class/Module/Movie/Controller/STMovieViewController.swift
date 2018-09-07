//
//  STMovieViewController.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2018/1/4.
//  Copyright © 2018年 申屠云飞. All rights reserved.
//

import UIKit
import RxSwift
import Then
import RxCocoa
import Moya
import Fuzi
import AVKit

class STMovieViewController: UIViewController {

//    @IBOutlet weak var tableView: UITableView!
    fileprivate let provider = MoyaProvider<MultiTarget>()
    
    var dataType: Int? {
        didSet {
            requestData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "test.mov", ofType: nil)!)
//        let player = AVPlayer(url: url)
//        
//        let vc = AVPlayerViewController()
//        vc.player = player
//        self.present(vc, animated: true) {
//            player.play()
//        }
    }
}

// MARK:- 初始化
extension STMovieViewController {
    /// 初始化
    func commonInit() {
        setupUI()
        autoLayout()
    }
    
    /// 设置视图
    func setupUI() {
        view.backgroundColor = UIColor.randomColor()
    }
    
    /// 自动布局
    func autoLayout() {
        
    }
}

// MARK:- 请求
extension STMovieViewController {
    func requestData() {
        
        provider.request(MultiTarget(HtmlAPI.movielist1)) { (result) in
            do {
                let response = try result.dematerialize()
                let html = try response.mapString()
                                print("=====>\(html)")
//                let doc = try HTMLDocument(string: html, encoding: String.Encoding.utf8)
//                if let mainDiv = doc.firstChild(css: "#main") {
//                    for a in mainDiv.xpath("//div[@class='ml-t fB']/a[1]") {
//                        print(a.stringValue)
//                    }
//                }
            }catch {
                
            }
        }
    }
}
