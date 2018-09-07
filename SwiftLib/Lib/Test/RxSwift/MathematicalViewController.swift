//
//  MathematicalViewController.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/14.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import UIKit
import RxSwift

class MathematicalViewController: UIViewController {

    fileprivate lazy var disposeBag : DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.randomColor()

//        toArray
//        reduce
//        concat
        
        
//        toArray
//        将一个Observable序列转化为一个数组，并转换为一个新的Observable序列发射，然后结束。
        Observable.of(1,2,3,4,5).toArray().subscribe(onNext: {print($0)}).disposed(by: disposeBag)
        
        print("-------------------------")
//        reduce
//        使用一个初始值和一个操作符，对Observable序列中的所有元素进行累计操作，并转换成单一事件信号。(PS:和map有的区别就是：map针对单个元素进行操作，reduce针对所有元素累计操作)
        Observable.of(1,10,100).reduce(1, accumulator: +).subscribe(onNext: {print($0)}).disposed(by: disposeBag)
        
        print("-------------------------")
//        concat
//        将两个Observable序列合并成一个Observable序列，当一个Observable序列中的所有元素成功发射完成之后，才会发射另一个Observable序列中的元素。
//        在第一个Observable发射完成之前，第二个Observable发射的事件都会被忽略，但会接收第一个Observable发射完成前第二个Observable发射的最后一个事件。
//        不好理解，举个例子:
        
        let subject1 = BehaviorSubject(value: "🍎")
        let subject2 = BehaviorSubject(value: "🐶")
        
        let variable = Variable(subject1)
        
        subject1.asObservable().concat(subject2.asObservable()).subscribe(onNext: { (str) in
            print("\(str)")
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
//        variable.asObservable()
//            .concat()
//            .subscribe { print($0) }
//            .disposed(by: disposeBag)
        
        subject1.onNext("🍐")
        subject1.onNext("🍊")
        
        variable.value = subject2
        subject2.onNext("I would be ignored")
        subject2.onNext("🐱")
        
        subject1.onCompleted()
        subject2.onNext("🐭")
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
