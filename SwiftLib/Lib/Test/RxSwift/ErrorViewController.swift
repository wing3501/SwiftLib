//
//  ErrorViewController.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/14.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import UIKit
import RxSwift

enum TestError:Error {
    case test
}

class ErrorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.randomColor()
        
//        RxSwift中的错误处理，包括：
//
//        catchErrorJustReturn
//        catchError
//        retry
//        retry(_:)
        
        //catchErrorJustReturn
//        遇到error事件的时候，返回一个值，并且结束
        let disposeBag = DisposeBag()
        
        let sequenceFail = PublishSubject<String>()
        sequenceFail.catchErrorJustReturn("😁").subscribe(onNext: {print($0)}).disposed(by: disposeBag)
        
        sequenceFail.onNext("😝")
        sequenceFail.onNext("😓")
        sequenceFail.onError(TestError.test)
        
        print("-------------------------")
//        catchError
//        捕获error进行处理，可以返回另一个sequence进行订阅。
        
        let sequenceThatFails = PublishSubject<String>()
        let recoverySequence = PublishSubject<String>()
        
        sequenceThatFails.catchError {
            print("Error:", $0)
            return recoverySequence
            }.subscribe { print($0) }.disposed(by: disposeBag)
        
        sequenceThatFails.onNext("😬")
        sequenceThatFails.onNext("😨")
        sequenceThatFails.onNext("😡")
        sequenceThatFails.onError(TestError.test)
        
        recoverySequence.onNext("😊")
        
        print("-------------------------")
//        retry
//        遇见error事件可以进行重试，比如网络请求失败，可以进行重新连接。
        
        var count = 1
        
        let retrySequence = Observable<String>.create { (observer) -> Disposable in
            observer.onNext("🍎")
            observer.onNext("🍐")
            
            if count == 1 {
                observer.onError(TestError.test)
                print("Error encountered")
                count += 1
            }
            
            observer.onNext("🐶")
            observer.onNext("🐱")
            
            return Disposables.create()
        }
        
        retrySequence.retry().subscribe(onNext: {print($0)}).disposed(by: disposeBag)
        
        
//        retry(_:)
//        与retry相同，只是指定了重试次数。
        
        let sequenceThatErrors = Observable<String>.create { observer in
            observer.onNext("🍎")
            observer.onNext("🍐")
            observer.onNext("🍊")
            
            if count < 5 {
                observer.onError(TestError.test)
                print("Error encountered")
                count += 1
            }
            
            observer.onNext("🐶")
            observer.onNext("🐱")
            observer.onCompleted()
            
            return Disposables.create()
        }
        
        sequenceThatErrors.retry(3).subscribe(onNext: { print($0) }).disposed(by: disposeBag)
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
