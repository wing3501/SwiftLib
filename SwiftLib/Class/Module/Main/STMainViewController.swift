//
//  STMainViewController.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/28.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import UIKit
import DrawerController
import Moya
import Alamofire
import Fuzi
import SnapKit
import Then

class STMainViewController: UIViewController {
    
    fileprivate let provider = MoyaProvider<MultiTarget>()
    fileprivate let urlView = STUrlView.loadFromNib()
    fileprivate var cellHeight: CGFloat = 0.0
    fileprivate lazy var mainUrl: String? = ""
    let mainCellID = "MainTableViewCell"
    
    
    fileprivate lazy var tableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.register(UINib(nibName:mainCellID,bundle:nil), forCellReuseIdentifier: mainCellID)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        bindModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        if mainUrl?.count == 0 {
//            showUrlView()
//        }
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

// MARK:- 设置视图
extension STMainViewController {
    func commonInit() {
        cellHeight = (kScreenH - 64) / 3.0
        
        view.backgroundColor = UIColor.white
        
        //        urlView.callback = {[weak self](string) in
        //            self?.mainUrl = string
        //            self?.getClassification()
        //        }
        view.addSubview(tableView)
        setupLeftMenuButton()
        setupRightMenuButton()
        autoLayout()
    }
    
    func autoLayout() {
        tableView.snp.makeConstraints { (make) in
            make.left.bottom.top.right.equalTo(view)
        }
    }
    
    func setupLeftMenuButton() {
        let leftDrawerButton = DrawerBarButtonItem(target: self, action: #selector(leftDrawerButtonPress(_:)))
        self.navigationItem.setLeftBarButton(leftDrawerButton, animated: true)
    }
    
    @objc func leftDrawerButtonPress(_ sender: AnyObject?) {
        self.evo_drawerController?.toggleDrawerSide(.left, animated: true, completion: nil)
    }
    
    func setupRightMenuButton() {
        let button = UIButton(type: .custom)
        button.setTitle("切换网址", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(showUrlView), for: .touchUpInside)
        
        let rightButton = UIBarButtonItem(customView: button)
        
        self.navigationItem.setRightBarButton(rightButton, animated: true)
    }
    
    @objc func showUrlView() {
        if mainUrl?.count == 0 {
            urlView.closeButton.isHidden = true
        }else{
            urlView.closeButton.isHidden = false
        }
        kWindow?.addSubview(urlView)
    }
}

// MARK:- 代理
extension STMainViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mainCellID, for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = STMovieViewController(nibName: nil, bundle: nil)
        vc.dataType = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK:- 绑定模型
extension STMainViewController {
    func bindModel() {
        
    }
}

// MARK:- 私有方法
extension STMainViewController {
    func getClassification() {
//        provider.request(MultiTarget(HtmlAPI.getClassification)) { (result) in
//            do {
//                let response = try result.dematerialize()
//                let html = try response.mapString()
//                print("=====>\(html)")
//                let doc = try HTMLDocument(string: html, encoding: String.Encoding.utf8)
//                if let mainDiv = doc.firstChild(css: "#main") {
////                    print(elementById.stringValue)
//
//                    for a in mainDiv.xpath("//div[@class='ml-t fB']/a[1]") {
//                        print(a.stringValue)
//                    }
//                }
//            }catch {
//
//            }
//        }
    }
    
    /// 测试
    func testGetClassification() {
//        provider.request(MultiTarget(HtmlAPI.getClassification)) { (result) in
//            do {
//                let response = try result.dematerialize()
//                let html = try response.mapString()
//                //                print("=====>\(html)")
//                let doc = try HTMLDocument(string: html, encoding: String.Encoding.utf8)
//                if let mainDiv = doc.firstChild(css: "#main") {
//                    //                    print(elementById.stringValue)
//                    
//                    for a in mainDiv.xpath("//div[@class='ml-t fB']/a[1]") {
//                        print(a.stringValue)
//                    }
//                }
//            }catch {
//                
//            }
//        }
    }
}

