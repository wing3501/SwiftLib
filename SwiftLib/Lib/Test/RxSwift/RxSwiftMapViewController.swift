//
//  RxSwiftMapViewController.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/12.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import UIKit
import RxSwift

struct Student {
    var score : Variable<Double>
}

struct Player {
    var score:Variable<Int>
}

class RxSwiftMapViewController: UIViewController {

    fileprivate lazy var bag : DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        // 1.Swift中如何使用map
        let array = [1,2,3,4]
        
//        let array2 = array.map { (num) -> Int in
//            return num * num
//        }
        
//        let array2 = array.map {
//            return $0 * $0
//        }
        
        let array2 = array.map {($0 * $0)}
        
        print(array2)
        
        
        
        // 2.在RxSwift中map函数的使用
        //通过使用一个闭包函数将原来的Observable序列转换为一个新的Observable序列。
        Observable.of(1,2,3,4).map { (num) -> Int in
            return num * num
            }.subscribe { (event) in
            print(event)
        }.disposed(by: bag)
        
        
        print("------------")
        
        // 3.flatMap使用
        //将一个Observable序列转换为另一个Observable序列，并且合并两个Observable序列。会按时间顺序接收两个序列发出的元素
        let stu1 = Student(score: Variable(80))
        let stu2 = Student(score: Variable(100))
        let studentVariable = Variable(stu1)
        
        studentVariable.asObservable().flatMap { (student) -> Observable<Double> in
                return student.score.asObservable()
            }.subscribe { (event) in
                print("stu:\(event)")
        }.disposed(by: bag)
        
//        studentVariable.asObservable().flatMapLatest { (student) -> Observable<Double> in
//            return student.score.asObservable()
//            }.subscribe { (event) in
//                print("stu:\(event)")
//        }.disposed(by: bag)
        
        
        studentVariable.value = stu2
        stu2.score.value = 0

        stu1.score.value = 1000//这个有打印
        
        print("------------")
        //4.flatMapLatest
//        flatMapLatest同flatMap一样，也是将一个序列转换为另一个序列，flatMapLatest只会从最近的序列中发出事件。
//        flatMapLatest = map + switchLatest
        
        let man = Player(score: Variable(80))
        let women = Player(score: Variable(90))
        
        let player = Variable(man)
//        player.asObservable().flatMapLatest({$0.score.asObservable()}).subscribe(onNext: {print($0)}).disposed(by: bag)
        player.asObservable().flatMapLatest { (p) -> Observable<Int> in
            return p.score.asObservable()
            }.subscribe(onNext: { (a) in
                print("\(a)")
            }).disposed(by: bag)
        
        man.score.value = 85
        player.value = women
        man.score.value = 95//这个没打印
        women.score.value = 100
        
        print("------------")
        //5.scan
        //scan就是提供一个初始化值，然后使用计算闭包不断将前一个元素和后一个元素进行处理，并将处理结果作为单个元素的Observable序列返回。
        Observable.of(10, 100, 1000)
            .scan(2) { aggregateValue, newValue in
                aggregateValue + newValue
            }
            .subscribe(onNext: { print($0) })
            .disposed(by: bag)
        
        
        print("------------")
        
        
        
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
