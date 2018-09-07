//
//  UIView-Extension.swift
//  SwiftLib
//
//  Created by 申屠云飞 on 2017/12/15.
//  Copyright © 2017年 申屠云飞. All rights reserved.
//

import UIKit


extension UIView {
    //    textLabel.roundCorners([.bottomLeft,.topLeft], radius: 10)
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}


extension UIView{
    var x:CGFloat{
        get{
            return self.frame.origin.x
        }
        set{
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    var y:CGFloat{
        get{
            return self.frame.origin.y
        }
        set{
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    var maxX:CGFloat{
        get{
            return self.frame.origin.x + self.frame.width
        }
    }
    
    var maxY:CGFloat{
        get{
            return self.frame.origin.y + self.frame.height
        }
    }
    func added(to superView:UIView)->Self{
        superView.addSubview(self)
        return self
    }
}
