//
//  RxRegisterViewController.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/14.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import UIKit
import RxSwift

class RxRegisterViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var pwdLabel: UILabel!
    
    @IBOutlet weak var rePwdTextField: UITextField!
    @IBOutlet weak var rePwdLabel: UILabel!
    
    @IBOutlet weak var registButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    fileprivate let disposeBag = DisposeBag()
    
    fileprivate let viewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        setupRx()

        viewModel.registerButtonEnabled.subscribe(onNext: { [weak self](valid) in
            self?.registButton.isEnabled = valid
            self?.registButton.alpha = valid ? 1 : 0.5
        }).disposed(by: disposeBag)
        
        viewModel.registerResult.subscribe(onNext: { [weak self](result) in
            switch result {
            case let .ok(message):
                self?.showAlert(message:message)
            case .empty:
                self?.showAlert(message:"")
            case let .failed(message):
                self?.showAlert(message:message)
            }
        }).disposed(by: disposeBag)
        
        loginButton.rx.tap.bind {[weak self] () in
            let vc = RxLoginViewController(nibName: nil, bundle: nil)
            self?.navigationController?.pushViewController(vc, animated: true)
            }.disposed(by: disposeBag)
    }
    
    func setupRx() {
        userNameTextField.rx.text.orEmpty.bind(to: viewModel.username).disposed(by: disposeBag)
        pwdTextField.rx.text.orEmpty.bind(to: viewModel.password).disposed(by: disposeBag)
        rePwdTextField.rx.text.orEmpty.bind(to: viewModel.rePassword).disposed(by: disposeBag)
        registButton.rx.tap.bind(to: viewModel.registerTaps).disposed(by: disposeBag)
        
        viewModel.usernameUseable.bind(to:nameLabel.rx.validationResult).disposed(by: disposeBag)
        viewModel.usernameUseable.bind(to:pwdTextField.rx.inputEnabled).disposed(by: disposeBag)
        viewModel.passwordUseable.bind(to: pwdLabel.rx.validationResult).disposed(by: disposeBag)
        viewModel.passwordUseable.bind(to: rePwdTextField.rx.inputEnabled).disposed(by: disposeBag)
        viewModel.rePasswordUseable.bind(to: rePwdLabel.rx.validationResult).disposed(by: disposeBag)
    }
    
    
    func showAlert(message:String) {
        let action = UIAlertAction(title: "确定", style: .default) { [weak self](_) in
            self?.userNameTextField.text = ""
            self?.pwdTextField.text = ""
            self?.rePwdTextField.text = ""
            
            // 这个方法是基于点击确定让所有元素还原才抽出的，可不搭理。
            self?.setupRx()
        }
        
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
