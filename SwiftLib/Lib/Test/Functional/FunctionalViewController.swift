//
//  FunctionalViewController.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/15.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import UIKit

class FunctionalViewController: UIViewController {
    typealias Filter = (CIImage) -> CIImage
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.randomColor()
        
        
        
    }

    //模糊
    func blur(radius: Double) -> Filter {
        return { image in
            let parameters = [ kCIInputRadiusKey: radius, kCIInputImageKey: image] as [String : Any]
            guard let  lter = CIFilter (name: "CIGaussianBlur",withInputParameters: parameters) else { fatalError() }
            guard let outputImage =  lter.outputImage else { fatalError() }
            
            return outputImage
        }
    }

    

}
