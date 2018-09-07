//
//  MoyaTableViewCell.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/22.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import UIKit
import Kingfisher

class MoyaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myImageView: UIImageView!
    
    var model:WPTProductModel?{
        didSet {
            if let cover = model?.cover {
                myImageView.kf.setImage(with: URL(string: cover))
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.randomColor()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
