//
//  RxLoginViewController.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/15.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import UIKit
import RxSwift


class RxLoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "登录"
        
        let viewModel = LoginViewModel(input: (username: usernameTextField.rx.text.orEmpty.asDriver(),
                                               password: passwordTextField.rx.text.orEmpty.asDriver(),
                                               loginTaps:loginButton.rx.tap.asDriver()),
                                       service: ValidationService.instance)
        
        viewModel.usernameUseable.drive(nameLabel.rx.validationResult).disposed(by: disposeBag)
        
        viewModel.loginButtonEnabled.drive(onNext: { [weak self] (valid) in
            self?.loginButton.isEnabled = valid
            self?.loginButton.alpha = valid ? 1.0 : 0.5
        }).disposed(by: disposeBag)
        
        viewModel.loginResult.drive(onNext: { [weak self](result) in
            switch result {
            case let .ok(message):
//                self?.performSegue(withIdentifier: "showListSegue", sender: nil)
                let vc = RxListViewController(nibName: nil, bundle: nil)
                self?.navigationController?.pushViewController(vc, animated: true)
                self?.showAlert(message: message)
            case .empty:
                self?.showAlert(message: "")
            case let .failed(message):
                self?.showAlert(message: message)
            }
        }).disposed(by: disposeBag)
    }
    
    func showAlert(message:String) {
        let action = UIAlertAction(title: "确定", style: .default, handler: nil)
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
