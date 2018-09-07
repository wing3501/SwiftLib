//
//  FilterViewController.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/14.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import UIKit
import RxSwift

class FilterViewController: UIViewController {

    fileprivate lazy var bag : DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.randomColor()
        
//        filter
//        distinctUntilChanged
//        elementAt
//        single
//        take
//        takeLast
//        takeWhile
//        takeUntil
//        skip
//        skipWhile
//        skipWhileWithIndex
//        skipUntil
        
        
//        filter
//        在Observable序列中只发出满足过滤条件的事件。
        Observable.of(1,2,3,4,5).filter({$0 > 2}).subscribe(onNext: {print($0)}).disposed(by: bag)
        
        print("-------------------------")
//        distinctUntilChanged
//        过滤连续发出的相同事件     显著变化时才发出事件
        Observable.of(1,2,3,3,3,2,2,5,4).distinctUntilChanged().subscribe(onNext: {print($0)}).disposed(by: bag)
        
        print("-------------------------")
//        elementAt
//        Observable只发出指定位置的事件
        Observable.of(1,2,3,5,4).elementAt(2).subscribe(onNext: {print($0)}).disposed(by: bag)
        
        print("-------------------------")
//        single
//        用法一：检测Observable序列是否发射一个元素。如果发射多个，会报错。
        
        // error:Sequence contains more than one element
//         Observable.of(1,2,3).single().subscribe(onNext: {print($0)}).disposed(by: bag)
        
        Observable.of(1).single().subscribe(onNext: {print($0)}).disposed(by: bag)
//        用法二：检测Observable序列发射的元素里面是否包含多个指定的元素，如果有多个或者没有，会报错。
        
        Observable.of("🐱", "🐰", "🐶", "🐸", "🐷", "🐵")
            .single { $0 == "🐸" }
            .subscribe { print($0) }
            .disposed(by: bag)
        
        Observable.of("🐱", "🐰", "🐶", "🐱", "🐰", "🐶")
            .single { $0 == "🐒" }
            .subscribe { print($0) }
            .disposed(by: bag)
        
        Observable.of("🐱", "🐰", "🐶", "🐶","🐸")
            .single { $0 == "🐶" }
            .subscribe { print($0) }
            .disposed(by: bag)

        print("-------------------------")
//        take
//        从Observable序列开始点起只处理前几个事件。
        Observable.of(1,2,3).take(2).subscribe(onNext: {print($0)}).disposed(by: bag)
        
        print("-------------------------")
//        takeLast
//        与take相反，从Observable序列的结束位置起，只处理前几个事件。
        Observable.of(1,2,3).takeLast(2).subscribe(onNext: {print($0)}).disposed(by: bag)
        
        print("-------------------------")
//        takeWhile
//        只处理满足条件的事件。感觉和filter没什么区别
        Observable.of(1,2,3,4,5).takeWhile{$0 < 3}.subscribe(onNext: {print($0)}).disposed(by: bag)
        
        print("-------------------------")
//        takeUntil
//        直到另一个Observable序列发出一个信号，则原序列终止。
        let orinSubject = PublishSubject<Int>()
        let refreSubject = PublishSubject<Int>()
        
        orinSubject.takeUntil(refreSubject).subscribe(onNext: {print($0)}).disposed(by: bag)
        
        orinSubject.onNext(1)
        orinSubject.onNext(2)
        refreSubject.onNext(10)
        orinSubject.onNext(3)
        
        print("-------------------------")
//        skip
//        从Observable序列的元素跳过指定个数。
        Observable.of(1,2,3,4,5,6).skip(2).subscribe(onNext: {print($0)}).disposed(by: bag)
        
        
        print("-------------------------")
//        skipWhile
//        跳过满足条件的事件，只要遇见不满足条件的事件，则该事件以及之后的事件（不管是否满足条件）都会发出。
        Observable.of(1,2,3,4,5,6,0,7).skipWhile{$0 < 3}.subscribe(onNext: {print($0)}).disposed(by: bag)
        
        print("-------------------------")
//        skipWhileWithIndex
//        跳过索引满足条件的事件。
        Observable.of(1,2,3,4,5,6).skipWhileWithIndex({ (element, index) -> Bool in
            index < 3
        }).subscribe(onNext: {print($0)}).disposed(by: bag)
        
        print("-------------------------")
//        skipUntil
//        跳过另一个Observable序列发出事件之前的所有事件。与takeUntil相反
        let oriSubject1 = PublishSubject<Int>()
        let refreSubject1 = PublishSubject<Int>()
        
        oriSubject1.skipUntil(refreSubject1).subscribe(onNext: {print($0)}).disposed(by: bag)
        
        oriSubject1.onNext(1)
        oriSubject1.onNext(2)
        
        refreSubject1.onNext(10)
        oriSubject1.onNext(3)
        oriSubject1.onNext(4)
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
