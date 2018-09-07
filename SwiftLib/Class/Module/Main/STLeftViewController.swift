//
//  STLeftViewController.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/29.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class STLeftViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    fileprivate let cellID = "STLeftTableViewCell"
    fileprivate let headerID = "STLeftHeader"
    fileprivate let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        bindModel()
    }

}
// MARK:- 初始化
extension STLeftViewController {
    /// 初始化
    func commonInit() {
//        edgesForExtendedLayout = .top
        extendedLayoutIncludesOpaqueBars = true;
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false;
        };
        tableView.contentInset = .zero
        tableView.delegate = self
        tableView.backgroundColor = UIColor.white
        tableView.register(UINib(nibName: headerID, bundle: nil), forHeaderFooterViewReuseIdentifier: headerID)
        tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
    }
    
}

// MARK:- 绑定模型
extension STLeftViewController {
    func bindModel() {
//        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        let items = Observable.just(["my_about","my_history","my_setup","my_share"])
        items
            .bind(to: tableView.rx.items) {[weak self] (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: (self?.cellID)!)! as! STLeftTableViewCell
                cell.leftImageView.image = UIImage(named: element)
                cell.leftTitleView.text = element
                return cell
            }
            .disposed(by: disposeBag)
    }
}

// MARK:- UITableViewDelegate
extension STLeftViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: headerID)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
}

