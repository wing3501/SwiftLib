//
//  RxListViewController.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/15.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import UIKit
import RxSwift

class RxListViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    var searchBarText:Observable<String> {
        return searchBar.rx.text.orEmpty.throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "联系人"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let viewModel = ListViewModel(with: searchBarText, service: SearchService.instance)
        
        viewModel.models.drive(tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)){(row, element, cell) in
            cell.textLabel?.text = element.name
            cell.detailTextLabel?.text = element.phone
            }.disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
