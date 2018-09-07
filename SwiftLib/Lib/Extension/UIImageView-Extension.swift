//
//  UIImageView-Extension.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/15.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import UIKit


extension UIImageView{
    //异步解压图片并设置图片
    func asyncSetImage(_ image:UIImage?){
        DispatchQueue.global(qos: .userInteractive).async {
            let decodeImage = image?.decodedImage()
            DispatchQueue.main.async {
                self.image = decodeImage
            }
        }
    }
}