//
//  ConnectableViewController.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/14.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import UIKit
import RxSwift

class ConnectableViewController: UIViewController {

    fileprivate lazy var bag : DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.randomColor()

//        Connectable Observable在订阅时不发射事件消息，而是仅当调用它们的connect()方法时才发射消息，这样就可以等待所有我们想要的订阅者都已经订阅了以后，再开始发出事件消息，这样能保证我们想要的所有订阅者都能接收到事件消息。其实也就是等大家都就位以后，开始发出消息。
        
//        在开始学习Connectable Observable之前，让我们来看一个non-connectable operator:
        
//        let intervar = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
//
//        _ = intervar.subscribe(onNext: {print("subscribe:1, event:\($0)")})
//
//        delay(5, closure: { (_) in
//            _ = intervar.subscribe(onNext: {print("subscribe:2, event:\($0)")})
//        })
        
        
//        Connectable Observable在RxSwift中包括了：
//
//        publish
//        replay
//        multicast
        
//        publish
//        将一个源Observable sequence转变为一个connectable sequence。
        
        let intervar = Observable<Int>.interval(1, scheduler: MainScheduler.instance).publish()
        
        _ = intervar.subscribe(onNext: {print("subscribe:1, event:\($0)")})
        
        _ = intervar.subscribe(onNext: {print("subscribe:2, event:\($0)")})
        
//        intervar.connect().disposed(by: bag)
//        你可以试试把intervar.connect()注释掉，会发现并没有任何响应。
        
        
        print("-------------------------")
//        replay
//        将一个正常的sequence转换成一个connectable sequence，然后和replaySubject相似，能接收到订阅之前的事件消息。
        
        let intSequence = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .replay(5)
        
        _ = intSequence
            .subscribe(onNext: { print("Subscription 1:, Event: \($0)") })
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
//             _ = intSequence.connect()
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4) {
            _ = intSequence
                .subscribe(onNext: { print("Subscription 2:, Event: \($0)") })
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 8) {
            _ = intSequence
                .subscribe(onNext: { print("Subscription 3:, Event: \($0)") })
        }
        
        print("-------------------------")
//        multicast
//        将一个正常的sequence转换成一个connectable sequence，并且通过特性的subject发送出去，比如PublishSubject，或者replaySubject，behaviorSubject等。不同的Subject会有不同的结果。
        
        let subject = PublishSubject<Int>()
        
        _ = subject
            .subscribe(onNext: { print("Subject: \($0)") })
        
        let intSequence1 = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .multicast(subject)
        
        _ = intSequence1
            .subscribe(onNext: { print("\tSubscription 1:, Event: \($0)") })
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            _ = intSequence1.connect()
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4) {
            _ = intSequence1
                .subscribe(onNext: { print("\tSubscription 2:, Event: \($0)") })
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 6) {
            _ = intSequence1
                .subscribe(onNext: { print("\tSubscription 3:, Event: \($0)") })
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
