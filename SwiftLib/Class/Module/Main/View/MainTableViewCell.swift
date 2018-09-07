//
//  MainTableViewCell.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2018/1/4.
//  Copyright © 2018年 申屠云飞. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.commonInit()
    }

}

// MARK:- 初始化
extension MainTableViewCell {
    /// 初始化
    func commonInit() {
        mainImageView.layer.cornerRadius = 10
        mainImageView.layer.masksToBounds = true
        mainImageView.image = #imageLiteral(resourceName: "fengjing")
    }
}
