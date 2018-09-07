//
//  CombinationViewController.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/14.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import UIKit
import RxSwift

class CombinationViewController: UIViewController {

    fileprivate lazy var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.randomColor()
        
//        Combination Operators在RxSwift中的实现有五种：
//
//        startWith
//        merge
//        zip
//        combineLatest
//        switchLatest
        
        
        //startWith
//        在Observable释放元素之前，发射指定的元素序列。更多详情
//        上面这句话是什么意思呢？翻译成大白话就是在发送一个东西之前，我先发送一个我指定的东西。
//        startWith和栈类似，先进后出。
        Observable.of(["C","C++","OC"]).startWith(["先吃饱饭再学习"]).startWith(["休息一下"]).subscribe({ (event) in
            print(event)
        }).disposed(by: bag)
        
        print("-------------------------")
//        将多个Observable组合成单个Observable,并且按照时间顺序发射对应事件。     只要一个序列发送消息，就会收到
        
//        merge
        let subject1 = PublishSubject<String>()
        let subject2 = PublishSubject<String>()
        Observable.of(subject1, subject2)
            .merge()
            .subscribe(onNext: { print($0) })
            .disposed(by: bag)
        
        subject1.onNext("🅰️")
        subject1.onNext("🅱️")
        subject2.onNext("①")
        subject2.onNext("②")
        subject1.onNext("🆎")
        subject2.onNext("③")
        
        print("-------------------------")
        
        
        //zip
//        将多个Observable(注意：必须是要成对)组合成单个Observable，当有事件到达时，会在每个序列中对应的索引上对应的元素发出。(ps:之前版本的RxSwift好像最多只能组合8个Observable)    必须两个都发送了消息，才会收到
       
        let subject3 = PublishSubject<String>()
        let subject4 = PublishSubject<String>()
        
        Observable.zip(subject3, subject4) { str1,str2 in
            "zip: \(str1)--\(str2)"
            }.subscribe(onNext: {print($0)}).disposed(by: bag)
        
        subject3.onNext("A")
        subject3.onNext("B")
        subject3.onNext("C")
        
        subject4.onNext("1")
        subject4.onNext("2")
        
        
        print("-------------------------")
        //combineLatest
//        当一个项目由两个Observables发射时，通过一个指定的功能将每个Observable观察到的最新项目组合起来，并根据该功能的结果发射事件
        
        let subject5 = PublishSubject<String>()
        let subject6 = PublishSubject<String>()
        
        Observable.combineLatest(subject5, subject6) { str1,str2 in
            "combineLatest: \(str1)--\(str2)"
            }.subscribe(onNext: {print($0)}).disposed(by: bag)
        
        subject5.onNext("A")
        
        subject6.onNext("1")
        subject6.onNext("2")
        
        subject5.onNext("B")
        subject5.onNext("C")
        
        print("-------------------------")
        //switchLatest
        //切换Observable队列。  取出信号中的信号
        
        let subject7 = BehaviorSubject(value: "1")
        let subject8 = BehaviorSubject(value: "A")
        
        let variable = Variable(subject7)
        
        variable.asObservable()
            .switchLatest()
            .subscribe(onNext: { print($0) })
            .disposed(by: bag)
        
        subject7.onNext("2")
        subject7.onNext("3")
        
        variable.value = subject8
        
        subject7.onNext("4")
        subject8.onNext("B")
        
        print("-------------------------")
        //6.withLatestFrom     第一个队列每发出一个信号，都与第二个队列最新的信号结合
        let s1 = PublishSubject<String>()
        let s2 = PublishSubject<String>()
        
        let s3 = s1.withLatestFrom(s2) { str1, str2 in
            return (str1 + str2)
        }

        
        s3.subscribe(onNext: { (s) in
            print("===>\(s)")
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: bag)
        
        s1.onNext("1")
        s2.onNext("A")
        s1.onNext("2")
        s2.onNext("B")
    }
}
