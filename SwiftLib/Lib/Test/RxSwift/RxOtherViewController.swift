//
//  RxOtherViewController.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/14.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import UIKit
import RxSwift
class RxOtherViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.randomColor()
        //observeOn() 和 subscribeOn()
        //subscribeOn()设置起点在哪个线程，observeOn()设置了后续工作在哪个线程。
        
//        someObservable
//            .doOneThing()  // 1
//            .observeOn(MainRouteScheduler.instance) // 2
//            .subscribeOn(OtherScheduler.instance) // 3
//            .subscribeNext { // 4
//                ......
//            }
//            .addDisposableTo(disposeBag)
//        所有动作都发生在当前的默认线程
//        observeOn()转换线程到主线程，下面所有的操作都在主线程
//        subscribeOn()规定动作一开始不是发生在默认线程，而是在OtherScheduler了。
//        如果我们之前没有调用observeOn()，那么这边会在OtherScheduler发生，但是我们前面调用了observeOn()，所以这个动作会在主线程中调用。
//        总结一下：subscribeOn()只是影响事件链开始默认的线程，而observeOn()规定了下一步动作发生在哪个线程中。
        
        
        //shareReplay
        let disposeBag = DisposeBag()
        
        let observable = Observable.just("🤣").map{print($0)}.share(replay: 1, scope: .forever)//map只运行一次
        
        observable.subscribe{print("Even:\($0)")}.disposed(by: disposeBag)
        observable.subscribe{print("Even:\($0)")}.disposed(by: disposeBag)
        
        //Driver
        
//        drive方法只能在Driver序列中使用，Driver有以下特点：
//
//        Driver序列不允许发出error，
//        Driver序列的监听只会在主线程中。
//        所以Driver是专为UI绑定量身打造的东西。
//        以下情况你可以使用Driver替换BindTo:
//
//        不能发出error;
//        在主线程中监听;
//        共享事件流;
        
        
//        let results = query.rx.text.asDriver()
//            .throttle(0.3, scheduler: MainScheduler.instance)
//            .flatMapLatest { query in
//                fetchAutoCompleteItems(query)
//                    .asDriver(onErrorJustReturn: [])  //当遇见错误需要返回什么
//        }   //不需要添加shareReplay(1)
//
//        results
//            .map { "\($0.count)" }
//            .drive(resultCount.rx.text)     //和bingTo()功能一样
//            .addDisposableTo(disposeBag)
//
//        results
//            .drive(resultTableView.rx.items(cellIdentifier: "Cell")) { (_, result, cell) in
//                cell.textLabel?.text = "\(result)"
//            }
//            .addDisposableTo(disposeBag)
        
    }

}

//自定义operator
//extension ObserverType {
//    func myMap<R>(transform: (E) -> R) -> Observable<R> {
//        return Observable.create{ observer in
//            let subscription = self.subscribe {e in
//                switch e{
//                case .next(let value):
//                    let result = transform(value)
//                    observer.on(.next(result))
//                case .error(let error):
//                    observer.on(.error(error))
//                case .completed:
//                    observer.on(.completed)
//                }
//            }
//            return subscription
//        }
//    }
//}

