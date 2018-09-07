//
//  RxSwiftViewController.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/12.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import UIKit
#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif

class RxSwiftViewController: UIViewController {
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var testLabel: UILabel!
    
    fileprivate lazy var bag : DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //1.监听按钮点击
        button1.rx.tap.subscribe { (event : Event<()>) in
            print("按钮1发生了点击")
            }.disposed(by: bag)
        
        (button2.rx.tap.subscribe({ (event) in
            print("按钮2发生了点击")
        })).disposed(by: bag)
        
        
        //2.监听UITextField的文字改变
//        textField.rx.text .subscribe { (event) in
//            print("输入:\(event.element!!)")
//        }.disposed(by: bag)
    
        textField.rx.text .subscribe(onNext: { (str) in
            print(str!)
        }).disposed(by: bag)
        
//        textField.rx.text.subscribe(onNext: { (str : String?) in
//            print(str!)
//        }).disposed(by: bag)
        
        
        // 3.将UITextField文字改变的内容显示在Label中
//        textField.rx.text .subscribe(onNext: { (str) in
//            self.testLabel.text = str
//        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: bag)

        textField.rx.text .bind(to: testLabel.rx.text).disposed(by: bag)
        
        
        // 4.KVO
        testLabel.rx.observe(String.self, "text").subscribe(onNext: { (str) in
            print("KVO:\(str!)")
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: bag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func observable(_ sender: Any) {
        let vc = ObservableViewController(nibName: nil, bundle: nil)
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func subject(_ sender: Any) {
        let vc = SubjectViewController(nibName: nil, bundle: nil)
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func rxSwiftMap(_ sender: Any) {
        let vc = RxSwiftMapViewController(nibName: nil, bundle: nil)
        present(vc, animated: true, completion: nil)
    }
    

    @IBAction func combination(_ sender: Any) {
        let vc = CombinationViewController();
        present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func filter(_ sender: Any) {
        let vc = FilterViewController();
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func mathematical(_ sender: Any) {
        let vc = MathematicalViewController();
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func connectable(_ sender: Any) {
        let vc = ConnectableViewController();
        present(vc, animated: true, completion: nil)
    }
    @IBAction func rrror(_ sender: Any) {
        let vc = ErrorViewController();
        present(vc, animated: true, completion: nil)
    }
    @IBAction func other(_ sender: Any) {
        let vc = RxOtherViewController();
        present(vc, animated: true, completion: nil)
    }
    
    
}
