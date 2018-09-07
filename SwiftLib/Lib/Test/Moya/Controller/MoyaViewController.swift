//
//  MoyaViewController.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/22.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import UIKit
import HandyJSON
import RxSwift
import Then
import RxCocoa
import Moya

class MoyaViewController: UIViewController {
    var bag: DisposeBag = DisposeBag()
    let cellID = "tableCell"
    let provider = MoyaProvider<MultiTarget>()
    
    
    
    lazy var tableView: UITableView = {
        var t = UITableView(frame: kScreenBounds, style: .plain)
        t.backgroundColor = UIColor.white
        t.rowHeight = 100
        t.delegate = self
        t.dataSource = self
        t.register(UINib(nibName:"MoyaTableViewCell",bundle:nil), forCellReuseIdentifier: cellID)
        return t
    }()
    
//    var tableView = UITableView(frame: kScreenBounds, style: .plain).then {
//        $0.backgroundColor = UIColor.white
//        $0.rowHeight = 100
////        $0.delegate = self
////        $0.dataSource = self
//        $0.register(UINib(nibName:"MoyaTableViewCell",bundle:nil), forCellReuseIdentifier: "tableCell")
//    }
    
    var dataArray:[WPTProductModel] = []
    var variable:Variable<[WPTProductModel]> = Variable([])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
//        requestData()
//        rxRequestData()
    
    //rxswift对tableView的支持
    bindTableView()
//    requestData()
//    testDownload()
        testUpload()
    }
    
    func setupUI() {
        view.addSubview(tableView)
    }
    
    
    func bindTableView() {
        
        //  负责数据绑定
        variable.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "tableCell", cellType: MoyaTableViewCell.self)) { (row, element, cell) in
                cell.model = element
            }
            .disposed(by: bag)
        
        // 监听点击cell 获取index
        tableView.rx.itemSelected.subscribe(onNext: { (index : IndexPath) in
            //            点击cell就刷新数据
            
            self.requestData()
            
        }).disposed(by: bag)
        
        
        // 监听点击cell 获取Model
        tableView.rx.modelSelected(WPTProductModel.self).subscribe(onNext: { (model : WPTProductModel) in
//            print(model.name)
        }).disposed(by: bag)
        
    }
    
    func requestData() {
        WPTAPIProvider.request(.guangguang) { (result) in
            do {
                let response = try result.dematerialize()
                let json = try response.mapString()
                if let model = WPTBaseModel.deserialize(from: json) {
                    let array = model.data?["list"]
                    if let arr = [WPTProductModel].deserialize(from: array as? NSArray) {
                        self.dataArray = arr as! [WPTProductModel]
                        self.variable.value = arr as! [WPTProductModel]
//                        self.tableView.reloadData()
                    }
                }

            } catch {
                let printableError = error as CustomStringConvertible
                self.showAlert("error", message: printableError.description)
            }
            
            
//            switch result {
//            case let .success(moyaResponse):
//                let data = moyaResponse.data;
//                let statusCode = moyaResponse.statusCode
//
//            case let .failure(error):
//                print("\(error)")
//            }
        }
    }
    
    
    func rxRequestData() {
        
//        WPTAPIProvider.rx.request(.guangguang).subscribe(onSuccess: { (response) in
//
//        }) { (error) in
//            let printableError = error as CustomStringConvertible
//            self.showAlert("error", message: printableError.description)
//        }.disposed(by: bag)
//
        
//        PrimitiveSequence
        
//        let a = WPTAPIProvider.rx.request(.guangguang)
        
        WPTAPIProvider.rx.request(.guangguang).mapJSON().asObservable().mapObject(type: WPTBaseModel.self).subscribe(onNext: { (baseModel) in
            let tempArray = baseModel.data?["list"] as? NSArray
            if let array = [WPTProductModel].deserialize(from: tempArray) {
                self.dataArray = array as! [WPTProductModel]
                self.tableView.reloadData()
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: bag)
    }
    
    
    func testDownload() {
        
//        print("测试下载")
//        DownloadAPIProvider.request(.download(fileUrl: "/image2017/12/20171223_zl_91_1/gamersky_01origin_01_201712231822BAB.jpg"), callbackQueue: DispatchQueue.main, progress: { (progress) in
//            print("进度：\(progress.progress)")
//        }) { (result) in
//            if(result.value!.statusCode == 200) {
//                print("下载成功")
//            }
//        }
        
        //多target测试
        provider.request(MultiTarget(DownloadAPI.download(fileUrl: "/image2017/12/20171223_zl_91_1/gamersky_01origin_01_201712231822BAB.jpg")), callbackQueue: DispatchQueue.main, progress: { (progress) in
            print("进度：\(progress.progress)")
        }) { (result) in
            if(result.value!.statusCode == 200) {
                print("下载成功")
            }
        }
    }
    
    
    func testUpload() {
        guard let path = Bundle.main.path(forResource: "22222", ofType: "jpg") else{
            return
        }
//        let image = UIImage(contentsOfFile: path)
//        print("\(String(describing: image))")
        print("开始上传")
        do{
            let data = try Data(contentsOf: URL(fileURLWithPath: path));
            provider.request(MultiTarget(UploadAPI.upload(data: data)), callbackQueue: DispatchQueue.main, progress: { (progress) in
                print("进度：\(progress.progress)")
            }) { (result) in
                
                do {
                    let response = try result.dematerialize()
                    let json = try response.mapString()
                    print("上传结果====>\(json)")
                    
                } catch {
                    let printableError = error as CustomStringConvertible
                    self.showAlert("error", message: printableError.description)
                }
                
                if(result.value!.statusCode == 200) {
                    print("上传成功")
                }
            }
            
        } catch {
            let printableError = error as CustomStringConvertible
            self.showAlert("error", message: printableError.description)
        }
        
        
        
    }
    
    fileprivate func showAlert(_ title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(ok)
        present(alertController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension MoyaViewController: UITableViewDataSource,UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MoyaTableViewCell
        cell.model = dataArray[indexPath.row]
        
        return cell
    }
}
