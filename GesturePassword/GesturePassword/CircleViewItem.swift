//
//  CircleViewItem.swift
//  GesturePassword
//
//  Created by 张建宇 on 16/3/14.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit

class CircleViewItem: UIView {
    
    var success:Bool = true
    var selected:Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clearColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        let context:CGContextRef = UIGraphicsGetCurrentContext()!
        if(selected){
            if(success){
                CGContextSetStrokeColorWithColor(context, UIColor(red: 117/255.0, green: 194/255.0, blue: 122/255.0, alpha: 1).CGColor)
                CGContextSetFillColorWithColor(context, UIColor(red: 117/255.0, green: 194/255.0, blue: 122/255.0, alpha: 1).CGColor)
            }else{
                CGContextSetStrokeColorWithColor(context, UIColor(red: 219/255.0, green: 84/255.0, blue: 84/255.0, alpha: 1).CGColor)
                CGContextSetFillColorWithColor(context, UIColor(red: 219/255.0, green: 84/255.0, blue: 84/255.0, alpha: 1).CGColor)
            }
            let frame:CGRect = CGRectMake(bounds.size.width/2 - self.bounds.size.width/8, bounds.size.height/2 - bounds.size.height/8, bounds.size.width/4, bounds.size.height/4)
            CGContextAddEllipseInRect(context,frame)
            CGContextFillPath(context)
        }else{
            CGContextSetStrokeColorWithColor(context, UIColor(red: 117/255.0, green: 194/255.0, blue: 122/255.0, alpha: 1).CGColor)
        }
        CGContextSetLineWidth(context, 2.0)
        let frame:CGRect = CGRectMake(2, 2, bounds.size.width - 3, bounds.size.height - 3)
        CGContextAddEllipseInRect(context, frame)
        CGContextStrokePath(context)
        if(success){
            CGContextSetFillColorWithColor(context, UIColor(red: 30/255.0, green: 175/255.0, blue: 235/255.0, alpha: 0.3).CGColor)
        }else{
            CGContextSetFillColorWithColor(context, UIColor(red: 280/255.0, green: 36/255.0, blue: 36/255.0, alpha: 0.3).CGColor)
        }
        
        CGContextAddEllipseInRect(context, frame)
        
        if(selected){
            CGContextFillPath(context)
        }
    }
    
}
