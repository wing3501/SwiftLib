//
//  UIImage-Extension.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/15.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import UIKit

struct ImageConst{
    static let bytesPerPixel = 4
    static let bitsPerComponent = 8
}

//解压缩图片
extension UIImage{
    func decodedImage()->UIImage?{
        guard let cgImage = self.cgImage else{
            return nil
        }
        guard let colorspace = cgImage.colorSpace else {
            return nil
        }
        let width = cgImage.width
        let height = cgImage.height
        let bytesPerRow = ImageConst.bytesPerPixel * width
        let ctx = CGContext(data: nil,
                            width: width,
                            height: height,
                            bitsPerComponent: ImageConst.bitsPerComponent,
                            bytesPerRow: bytesPerRow,
                            space: colorspace,
                            bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue)
        guard let context = ctx else {
            return nil
        }
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        context.draw(cgImage, in: rect)
        guard let drawedImage = context.makeImage() else{
            return nil
        }
        let result = UIImage(cgImage: drawedImage, scale:self.scale , orientation: self.imageOrientation)
        return result
    }
}
