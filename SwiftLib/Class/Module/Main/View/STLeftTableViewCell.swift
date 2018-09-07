//
//  STLeftTableViewCell.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2018/1/2.
//  Copyright © 2018年 申屠云飞. All rights reserved.
//

import UIKit

class STLeftTableViewCell: UITableViewCell {
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var leftTitleView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
