//
//  OneViewController.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/8.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import UIKit

//protocol AlertViewDelegate: class {
//    func buttonTapped(atIndex: Int)
//}

//class IteratorStore<I: IteratorProtocol> where I.Element == Int {
//    var iterator: I
//    init(iterator: I) {
//        self.iterator = iterator
//    }
//}

class OneViewController: UIViewController, Emitterable {

    fileprivate lazy var nextButton = UIButton()
    fileprivate lazy var backButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.cyan

        nextButton.frame = CGRect(x: 50, y: 100, width: 100, height: 50);
        nextButton.setTitle("下一个", for: .normal)
        nextButton.backgroundColor = UIColor.green
        nextButton.addTarget(self, action: #selector(goNext), for: .touchUpInside)
        
        backButton.frame = CGRect(x: 50, y: 200, width: 100, height: 50);
        backButton.setTitle("返回", for: .normal)
        backButton.backgroundColor = UIColor.green
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        
        view.addSubview(nextButton)
        view.addSubview(backButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func goNext() {
        navigationController?.pushViewController(TwoViewController(nibName: nil, bundle: nil), animated: true)
    }
    
    @objc func back() {
        dismiss(animated: true, completion: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //测试日志
//        log(condition: false, message: "测试一下日志")
        
        
//       let lazyResult = (1...20).lazy.filter { $0 % 3 == 0 }.map { $0 * $0 }
//       let array = Array(lazyResult)
//       print("\(array)")
//
//        for a in array.smaller() {
//            print("==\(a)")
//        }
        
//        var array1 = [1,2,3]
//        let array2 = array1
        
//        array1.append(4)
        
//        str.withUnsafeBytes { print($0) }
        
//        array1.withUnsafeBytes { print("1===\($0)")}
//        array2.withUnsafeBytes { print("2===\($0)")}
//        
//        print("== \(array1) == \(array2)")
        
        
//        let suits = ["♠", "♥", "♣", "♦"]
//        let ranks = ["J","Q","K","A"]
//        let result = suits.flatMap { suit in
//            ranks.map { rank in
//            (suit, rank)
//            }
//        }
//
//        print("=====\(result)")
//
//        let slice = suits[2...suits.endIndex]
        
        
//        let defaultSettings: [String:String] = [ "Mode": "Airplane Mode11", "Name": "My iPhone"]
//
//        var localizedSettings = defaultSettings//深拷贝
//        localizedSettings["Name"] = "Mein iPhone"
//
//        print("\(defaultSettings)")
//        print("\(localizedSettings)")
        
        
//        var dic = ["key1":"value1","key2":"value2"]
        
//        let array = [1,2,3,4,2]
        
        
        
//        let aa = NSSortDescriptor(key: #keyPath(), ascending: <#T##Bool#>, selector: <#T##Selector?#>)
        
//        areInIncreasingOrder
    }
    
    
    ///测试粒子动画
    func testEmittering(_ touches: Set<UITouch>) {
        print("🌰")
        stopEmittering()
        
        let point = touches.first?.location(in: view)
        startEmittering(point!)
    }
}


protocol IteratorProtocol {
    associatedtype Element
    mutating func next() -> Element?
}


struct FileLinesIterator: IteratorProtocol {
    let lines: [String]
    var currentLine: Int = 0
    init( lename: String) throws {
        let contents: String = try String(contentsOfFile:  lename)
        lines = contents.components(separatedBy: .newlines)
        
    }
    mutating func next() -> String? {
        guard currentLine < lines.endIndex else { return nil }
        defer { currentLine += 1 }
        return lines[currentLine]
    }
    
}

extension IteratorProtocol {
    mutating func find(predicate: (Element) -> Bool) -> Element? {
        while let x = next() {
            if predicate(x) {
            return x
            }
        }
        return nil
    }
    
}

extension Array {
    func smaller() -> AnyIterator<[Element]> {
        var i = 0
        return AnyIterator {
            guard i < self.endIndex else { return nil }
            var result = self
            result.remove(at: i)
            i+=1
            return result
        }
        
    }
}




struct Position {
    var x: Double
    var y: Double
}

struct Region<T> {
    let value: (Position) -> T
}

extension Region {
    func map<U>(transform: @escaping (T) -> U) -> Region<U> {
        return Region<U> { pos in transform(self.value(pos)) }
    }
}

precedencegroup Apply { associativity: left }
infix operator <*>: Apply

func pure<A>(_ value: A) -> Region<A> {
    return Region { pos in value }
}
func <*><A, B>(regionF: Region<(A) -> B>, regionX: Region<A>) -> Region<B> {
    return Region { pos in regionF.value(pos)(regionX.value(pos)) }
}


extension Sequence {
    func last(where predicate: (Iterator.Element) -> Bool) -> Iterator.Element? {
        for element in reversed() where predicate(element) {
            return element
        }
        return nil
    }
}



