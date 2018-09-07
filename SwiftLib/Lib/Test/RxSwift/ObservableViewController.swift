//
//  ObservableViewController.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/12.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import UIKit
import RxSwift


class ObservableViewController: UIViewController {
    
    fileprivate lazy var bag : DisposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.yellow
        // 1.创建一个never的Obserable   创建一个永不终止且不发出任何事件的序列
        let never0 = Observable<String>.never()
        never0.subscribe { (event) in
            print(event)
        }.disposed(by: bag)
        
        // 2.创建一个empty的Obserable   创建一个只发送completed事件的空Observable序列
        let empty0 = Observable<String>.empty()
        empty0.subscribe { (event) in
            print(event)
        }.disposed(by: bag)
        
        
        print("--------------------")
        // 3.创建一个just的Obserable   创建一个只有一个元素的Observable序列
        let just0 = Observable.just("styf")
        just0.subscribe { (event) in
            print("just0:\(event)")
        }.disposed(by: bag)
        
        print("--------------------")
        // 4.创建一个of的Obserable    创建一个固定数量元素的Observable序列
        let of0 = Observable.of("a","b","c")
        of0.subscribe { (event) in
            print("of0:\(event)")
        }.disposed(by: bag)
        
        
        print("--------------------")
        // 5.创建一个from的Obserable   从一个序列(如Array/Dictionary/Set)中创建一个Observable序列
        let array = [1,2,3,4,5]
        let from0 = Observable.from(array)
        from0.subscribe { (event) in
            print("from0:\(event)")
        }.disposed(by: bag)
        
        print("--------------------")
        // 6.创建一个create的Obserable
        let create0 = createObservable()
        create0.subscribe { (event) in
            print("create0:\(event)")
        }.disposed(by: bag)
        
        
        let myJust0 = myJustObserable(element: "styf-styf")
        myJust0.subscribe { (event) in
            print("create0:\(event)")
        }.disposed(by: bag)
        
        print("--------------------")
        
        // 7.创建一个Range的Obserable  创建一个Observable序列，它会发出一系列连续的整数，然后终止
        let range0 = Observable.range(start: 1, count: 10)
        range0.subscribe { (event) in
            print("range0:\(event)")
        }.disposed(by: bag)
        
        print("--------------------")
        
        // 8.repeatElement    创建一个Observable序列，它可以无限地释放给定元素
        let repeat0 = Observable.repeatElement("hello")
        repeat0.take(5).subscribe { (event) in
            print("repeat0:\(event)")
        }.disposed(by: bag)
        
        print("--------------------")
        // 9.generate    创建一个Observable序列，只要提供的条件值为true就可以生成值。
        let generate0 = Observable.generate(initialState: -1, condition: {$0 < 3}, iterate: {$0 + 1})
        generate0.subscribe(onNext: { (a) in
            print("generate0:\(a)")
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: bag)
        
        
        //10.deferred    为每一个订阅者创建一个新的Observable序列。
        let deferred0 = Observable<String>.deferred {
            return Observable.create({ (observer) -> Disposable in
                observer.onNext("aa")
                observer.onNext("bb")
                observer.onNext("cc")
                
                return Disposables.create()
            })
        }
        
        deferred0.subscribe { (str) in
            print("deferred 1:\(str)")
        }.disposed(by: bag)
        
        deferred0.subscribe { (str) in
            print("deferred 2:\(str)")
        }.disposed(by: bag)
        
        print("--------------------")
        //11.error     创建一个不会发送任何条目并且立即终止错误的Observable序列
        let error = Observable<Int>.error(MyError.errorOne)
        error.subscribe(onNext: { (a) in
            print("\(a)")
        }, onError: { (e) in
            print("error: \(e)")
        }, onCompleted: nil, onDisposed: nil).disposed(by: bag)
        
        
        print("--------------------")
        //12.do
        let do0 = Observable.of(["元素1","元素2","元素3"]).do(onNext: { (str) in
            print("do:\(str)")
        }, onError: { (error) in
            print("do:\(error)")
        }, onCompleted: {
            print("do onCompleted")
        }, onSubscribe: {
            print("do onSubscribe")
        }, onSubscribed: {
            print("do onSubscribed")
        }) {
            print("do onDispose")
        }
        
        do0.subscribe(onNext: { (s) in
            print("do0 subscribe: \(s)")
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: bag)
    }

}

extension ObservableViewController {
    fileprivate func createObservable() -> Observable<Any> {
        return Observable.create({ (observer) -> Disposable in
            observer.onNext("styf")
            observer.onNext(18)
            observer.onCompleted()
            
            return Disposables.create()
        })
    }
    
    fileprivate func myJustObserable(element : String) -> Observable<String> {
        return Observable.create({ (observer : AnyObserver<String>) -> Disposable in
            observer.onNext(element)
            observer.onCompleted()
            
            return Disposables.create()
        })
    }
}


enum MyError: Int,Error {
    case errorOne = 100
    case errorTwo = 200
}
