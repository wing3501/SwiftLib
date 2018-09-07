//
//  SubjectViewController.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/12.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import UIKit
import RxSwift

class SubjectViewController: UIViewController {
    fileprivate lazy var bag : DisposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.green

        // 1.PublishSubject, 订阅者只能接受, 订阅之后发出的事件
        let publishSub = PublishSubject<String>()
        publishSub.onNext("订阅之前")
        publishSub.subscribe { (event) in
            print("PublishSubject:\(event)")
        }.disposed(by: bag)
        publishSub.onNext("订阅之后")
        
        print("-------------------------")
        
        // 2.ReplaySubject, 订阅者可以接受订阅之前的事件&订阅之后的事件
        let replaySub = ReplaySubject<String>.createUnbounded()
        replaySub.onNext("订阅之前1")
        replaySub.onNext("订阅之前2")
        replaySub.subscribe { (event) in
            print("replaySub:\(event)")
        }.disposed(by: bag)
        replaySub.onNext("订阅之后1")
        
        
//        ReplaySubject具有重放(replay)的功能，replay的个数可以通过参数指定。我们可以将其理解为缓存的效果。
//        一般我们使用ReplaySubject的时候，都是先发射，后订阅，然后通过指定缓存的大小，可以获取对应的值。(注意：不考虑Error和Completed)。
        let replaySub0 = ReplaySubject<Int>.create(bufferSize: 1)
        replaySub0.onNext(0)
        replaySub0.onNext(1)
        replaySub0.onNext(2)
        replaySub0.subscribe(onNext: { (a) in
            print("replaySub0:\(a)")
        }).disposed(by: bag)
        
        print("-------------------------")
        
        // 3.BehaviorSubject, 订阅者可以接受,订阅之前的最后一个事件
        let behaviorSub = BehaviorSubject(value: "啥")
        behaviorSub.subscribe { (event) in
            print("BehaviorSubject:\(event)")
        }.disposed(by: bag)
        behaviorSub.onNext("e")
        behaviorSub.onNext("f")
        behaviorSub.onNext("g")
        
        print("-------------------------")
        
        // 4.Variable
        /*
         Variable
         1> 相当于对BehaviorSubject进行装箱
         2> 如果想将Variable当成Obserable, 让订阅者进行订阅时, 需要asObserable转成Obserable
         3> 如果Variable打算发出事件, 直接修改对象的value即可
         4> 当事件结束时,Variable会自动发出completed事件
         */
        
        let variable = Variable("a")
        
        variable.value = "b"
        variable.asObservable().subscribe { (event) in
            print("variable:\(event)")
        }.disposed(by: bag)
        
        variable.value = "c"
        variable.value = "d"
        
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
