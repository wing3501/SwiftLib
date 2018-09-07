//
//  ListViewModel.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/15.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class ListViewModel {
    var models:Driver<[Contact]>
    
    init(with searchText:Observable<String>, service:SearchService){
        models = searchText.debug()
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMap { text in
                return service.getContacts(withName: text)
            }.asDriver(onErrorJustReturn:[])
    }
}
