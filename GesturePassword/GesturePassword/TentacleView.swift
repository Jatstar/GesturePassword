//
//  TentacleView.swift
//  GesturePassword
//
//  Created by 张建宇 on 16/3/14.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit


protocol ResetDelegate
{
    func resetPassword(result:String) -> Bool
}

protocol VerificationDelegate
{
    func verification(result:String) -> Bool
}

protocol TouchBeginDelegate{
    
    func gestureTouchBegin()
}

class TentacleView: UIView {
    
    var buttonArray:[CircleViewItem]=[]
    var touchesArray:[Dictionary<String,Float>]=[]
    var touchedArray:[String] = []
    
    
    var lineStartPoint:CGPoint?
    var lineEndPoint:CGPoint?
    
    var rerificationDelegate:VerificationDelegate?
    var resetDelegate:ResetDelegate?
    var touchBeginDelegate:TouchBeginDelegate?
    
    var style:Int?
    
    var success:Bool = false
    var drawed:Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
        self.userInteractionEnabled = true
        success = true
    }
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)!
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

        var touchPoint:CGPoint
        let touch:UITouch? = touches.first
        
        touchesArray.removeAll()
        touchedArray.removeAll()
        
        touchBeginDelegate!.gestureTouchBegin()
        
        
        success = true
        drawed = false
        
        if(touch != nil){
            
            
            touchPoint = touch!.locationInView(self)
            
            
            for(var i=0;i<buttonArray.count;i += 1){
                
                let buttonTemp = buttonArray[i]
                buttonTemp.success = true
                buttonTemp.selected = false
                
                if(CGRectContainsPoint(buttonTemp.frame,touchPoint)){
                    let frameTemp = buttonTemp.frame
                    let point = CGPointMake(frameTemp.origin.x+frameTemp.size.width/2,frameTemp.origin.y+frameTemp.size.height/2)
                    
                    var dict:Dictionary<String,Float> = [:]
                    dict["x"] = Float(point.x)
                    dict["y"] = Float(point.y)
                    //dict["num"] = Float(i)
                    
                    touchesArray.append(dict)
                    lineStartPoint = touchPoint
                    
                }
                
                buttonTemp.setNeedsDisplay()
            }
            
            self.setNeedsDisplay()
            
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {

        var touchPoint:CGPoint
        let touch:UITouch? = touches.first
        
        
        if(touch != nil){
            
            
            touchPoint = touch!.locationInView(self)
            
            for(var i=0;i<buttonArray.count;i += 1){
                
                let buttonTemp = buttonArray[i]
                
                if(CGRectContainsPoint(buttonTemp.frame,touchPoint)){
                    
                    let tps = touchedArray.filter{el in el=="num\(i)"}
                    
                    if(tps.count > 0){
                        
                        lineEndPoint = touchPoint
                        self.setNeedsDisplay()
                        return
                    }
                    touchedArray.append("num\(i)")
                    buttonTemp.selected = true
                    
                    buttonTemp.setNeedsDisplay()
                    
                    let frameTemp = buttonTemp.frame
                    let point = CGPointMake(frameTemp.origin.x+frameTemp.size.width/2,frameTemp.origin.y+frameTemp.size.height/2)
                    var dict:Dictionary<String,Float> = [:]
                    dict["x"] = Float(point.x)
                    dict["y"] = Float(point.y)
                    dict["num"] = Float(i)
                    
                    touchesArray.append(dict)
                    
                    break;
                    
                }
            }
            
            lineEndPoint = touchPoint
            self.setNeedsDisplay()
        }
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {

        var resultString:String = ""
        
        for p in touchesArray {
            if(p["num"] == nil){
                continue
            }
            let num=Int(p["num"]!)
            resultString = resultString + "\(num)"
        }
        drawed = true
        if(style==1){
            
            success = rerificationDelegate!.verification(resultString)
            
        }else{
            success = resetDelegate!.resetPassword(resultString)
        }
        
        for i in 0..<touchesArray.count {
            
            if(touchesArray[i]["num"] == nil){
                continue
            }
            
            let selection:Int = Int(touchesArray[i]["num"]!)
            let buttonTemp = buttonArray[selection]
            buttonTemp.success = success
            buttonTemp.setNeedsDisplay()
        }
        self.setNeedsDisplay()
        
    }
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        if(touchesArray.count<=0){
            return;
        }
        
        for var i=0;i<touchesArray.count;i += 1 {
            
            let context:CGContextRef = UIGraphicsGetCurrentContext()!
            
            if(touchesArray[i]["num"] == nil){
                touchesArray.removeAtIndex(i)
                continue
            }
            
            if (success) {
                CGContextSetStrokeColorWithColor(context, UIColor(red: 2/255.0, green: 174/255.0, blue: 240/255.0, alpha: 0.7).CGColor)
            }
            else {
                CGContextSetStrokeColorWithColor(context, UIColor(red: 208/255.0, green: 36/255.0, blue: 36/255.0, alpha: 0.7).CGColor)
            }
            
            CGContextSetLineWidth(context,5)
            
            CGContextMoveToPoint(context,CGFloat(touchesArray[i]["x"]!),CGFloat(touchesArray[i]["y"]!))
            
            if(i<touchesArray.count-1){
                
                CGContextAddLineToPoint(context,CGFloat(touchesArray[i+1]["x"]!),CGFloat(touchesArray[i+1]["y"]!))
            }
            else{
                
                if(success && drawed != true){
                    CGContextAddLineToPoint(context, lineEndPoint!.x,lineEndPoint!.y);
                }
            }
            CGContextStrokePath(context)
            
        }
    }
    
    
    
    func enterArgin() {
        
        touchesArray.removeAll()
        touchedArray.removeAll()
        
        for(var i=0;i<buttonArray.count;i += 1){
            
            let buttonTemp = buttonArray[i]
            buttonTemp.success = true
            buttonTemp.selected = false
            buttonTemp.setNeedsDisplay()
        }
        self.setNeedsDisplay()
    }

}

