//
//  STUrlView.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/29.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class STUrlView: UIView,NibLoadable {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var contentViewMult: NSLayoutConstraint!
    @IBOutlet weak var startButtonMult: NSLayoutConstraint!
    @IBOutlet weak var startButtonScale: NSLayoutConstraint!
    
    fileprivate let disposeBag = DisposeBag()
    fileprivate let url = Variable<String>("")
    var callback: ((String) -> Void)?
    
    override func awakeFromNib() {
        commonInit()
        bindModel()
    }
}

// MARK:- 初始化
extension STUrlView {
    func commonInit() {
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        contentView.backgroundColor = UIColor(hex: DarkColor)
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        
        confirmButton.backgroundColor = UIColor(r: 255, g: 195, b: 72)
        confirmButton.layer.cornerRadius = kScreenW * contentViewMult.multiplier * startButtonMult.multiplier / startButtonScale.multiplier * 0.5
        confirmButton.layer.masksToBounds = true
        
        confirmButton.layer.cornerRadius = 10
        confirmButton.layer.masksToBounds = true
        confirmButton.isEnabled = false;
    }
}

// MARK:- 布局
extension STUrlView {
    override func didMoveToSuperview() {
        if let newSuperview = superview {
            self.snp.makeConstraints({ (make) in
                make.left.top.bottom.right.equalTo(newSuperview)
            })
        }
    }
}

// MARK:- 绑定模型
extension STUrlView {
    func bindModel() {
        urlTextField.rx.text.orEmpty.bind(to: url).disposed(by: disposeBag)
        let urlUseable = url.asObservable().flatMapLatest {string in
            return STUrlView.validateUrl(string)
        }.share()

        urlUseable.bind(to: errorLabel.rx.validationResult).disposed(by: disposeBag)
        urlUseable.bind(to: confirmButton.rx.clickEnabled).disposed(by: disposeBag)

        confirmButton.rx.tap.subscribe(onNext: {[weak self] () in
            if let callback = self?.callback {
                callback((self?.url.value)!)
            }
            self?.removeFromSuperview()
        }).disposed(by: disposeBag)
        
        closeButton.rx.tap.subscribe(onNext: {[weak self] () in
            self?.removeFromSuperview()
        }).disposed(by: disposeBag)
    }
    
    static func validateUrl(_ url: String) -> Observable<RxResult>{
        if url.count == 0 { // 当字符串为空的时候，什么也不做
            return Observable.just(RxResult.empty)
        }
        
        if !url.isUrl() {
            return Observable.just(RxResult.failed(message: "不是一个url"))
        }
        
        return Observable.just(RxResult.ok(message: "url可用"))
    }
    
}

extension Reactive where Base:UIButton {
    var clickEnabled: Binder<RxResult> {
        return Binder(base) {button, result in
            button.isEnabled = result.isValid
        }
    }
}
