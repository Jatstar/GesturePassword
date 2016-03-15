//
//  GesturePasswordView.swift
//  GesturePassword
//
//  Created by 张建宇 on 16/3/14.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit

protocol GesturePasswordDelegate
{
    func forget()
}

class GesturePasswordView: UIView,TouchBeginDelegate {
    
    var tentacleView:TentacleView?
    
    var state:UILabel?
    
    var imgView:UIImageView?
    
    var forgetButton:UIButton?
    
    var gesturePasswordDelegate:GesturePasswordDelegate?
    
    private var buttonArray:[CircleViewItem]=[]
    
    private var lineStartPoint:CGPoint?
    private var lineEndPoint:CGPoint?

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        // Initialization code
        
        let view = UIView(frame:CGRectMake(frame.size.width/2-160, frame.size.height/2-80, 320, 320))
        
        for i in 0..<9 {
            
            let row = Int(i/3)
            let col = Int(i%3)
            
            let distance = Int(320/3)
            let size:Int = Int(Float(distance)/1.5)
            let margin = Int(size/4)
            
            let gesturePasswordButton = CircleViewItem(frame: CGRectMake(CGFloat(col*distance+margin), CGFloat(row*distance), CGFloat(size), CGFloat(size)))
            
            gesturePasswordButton.tag = i
            
            view.addSubview(gesturePasswordButton)
            buttonArray.append(gesturePasswordButton)
            
        }
        
        
        self.addSubview(view)
        
        tentacleView = TentacleView(frame: view.frame)
        
        tentacleView!.buttonArray = buttonArray
        tentacleView!.touchBeginDelegate = self
        self.addSubview(tentacleView!)
        
        state = UILabel(frame: CGRectMake(frame.size.width/2-140, frame.size.height/2-120, 280, 30))
        state!.textAlignment = NSTextAlignment.Center
        state!.font = UIFont.systemFontOfSize(14)
        self.addSubview(state!)
        
        imgView = UIImageView(frame:CGRectMake(frame.size.width/2-35, frame.size.width/2-80, 70, 70))
        imgView?.backgroundColor = UIColor.whiteColor()
        imgView!.layer.cornerRadius = 35
        imgView!.layer.borderColor = UIColor.grayColor().CGColor
        imgView!.layer.borderWidth = 3
        self.addSubview(imgView!)
        
        forgetButton = UIButton(frame:CGRectMake(frame.size.width/2-150, frame.size.height/2+220, 120, 30))
        forgetButton!.titleLabel?.font = UIFont.systemFontOfSize(14)
        forgetButton!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        forgetButton!.setTitle("忘记手势密码", forState: UIControlState.Normal)
        forgetButton!.addTarget(self, action: Selector("forget"), forControlEvents: UIControlEvents.TouchDown)
        self.addSubview(forgetButton!)
    }
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)!
    }
    
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext();
        
        let rgb = CGColorSpaceCreateDeviceRGB();
        let colors:[CGFloat] = [134/255,157/255,147/255,1.0,3/255,3/255,37/255,1.0]
        
        let  nilUnsafePointer:UnsafePointer<CGFloat> = nil
        
        let gradient = CGGradientCreateWithColorComponents(rgb, colors, nilUnsafePointer,2)
        
//        CGGradientDrawingOptions(rgb)
        
        CGContextDrawLinearGradient(context, gradient, CGPointMake(0.0,0.0),CGPointMake(0.0,self.frame.size.height), CGGradientDrawingOptions(rawValue: 0))
    }
    
    
    
    func gestureTouchBegin(){
        
        self.state!.text = ""
    }
    
    func forget(){
     print(__FUNCTION__)
        if(gesturePasswordDelegate != nil){
            gesturePasswordDelegate!.forget()
        }
    }
}
