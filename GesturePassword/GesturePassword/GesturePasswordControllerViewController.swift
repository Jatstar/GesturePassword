//
//  GesturePasswordControllerViewController.swift
//  GesturePassword
//
//  Created by 张建宇 on 16/3/14.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit

enum VerifyType{
    case ToChange
    case ToClean
    case ToDismiss
}

class GesturePasswordControllerViewController: UIViewController,VerificationDelegate,ResetDelegate{
    
    var type:VerifyType = VerifyType.ToDismiss

    var gesturePasswordView:GesturePasswordView!
    
    var previousString:String? = ""
    
    var password:String? = GesturePasswordModel.getGesturePassword()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        previousString = ""

        if password == "" || password == nil {
            
            self.reset()
        }
        else{
            self.verify()
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if type == .ToDismiss {
            UIApplication.sharedApplication().delegate?.window!?.windowLevel = UIWindowLevelAlert + 1
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if type == .ToDismiss {
            UIApplication.sharedApplication().delegate?.window!?.windowLevel = UIWindowLevelNormal
        }
    }
    
    //MARK: - 验证手势密码
    func verify(){
        
        gesturePasswordView = GesturePasswordView(frame: UIScreen.mainScreen().bounds)
        gesturePasswordView.tentacleView!.rerificationDelegate = self
        gesturePasswordView.state!.textColor = UIColor(red: 2/255, green: 174/255, blue: 240/255, alpha: 1)
        gesturePasswordView.state?.text = "请验证手势密码"
        gesturePasswordView.tentacleView!.style = 1
        self.view.addSubview(gesturePasswordView)
        
    }
    
    //MARK: - 重置手势密码
    func reset(){
        
        gesturePasswordView = GesturePasswordView(frame: UIScreen.mainScreen().bounds)
        gesturePasswordView.tentacleView!.resetDelegate = self
        gesturePasswordView.tentacleView!.style = 2
        gesturePasswordView.state!.textColor = UIColor(red: 2/255, green: 174/255, blue: 240/255, alpha: 1)
        gesturePasswordView.state?.text = "请设置手势密码"

        gesturePasswordView.forgetButton!.hidden = true
        self.view.addSubview(gesturePasswordView)
        
    }
    
    func verification(result:String)->Bool{
        if result == password {
            
            gesturePasswordView.state!.textColor = UIColor(red: 2/255, green: 174/255, blue: 240/255, alpha: 1)
            gesturePasswordView.state!.text = "输入正确"
            switch type{
            case .ToDismiss:
                self.dismissViewControllerAnimated(true, completion: nil)
            case .ToChange:
                self.reset()
            case .ToClean:
                GesturePasswordModel.clear()
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            
            return true
        }
        gesturePasswordView.state!.textColor = UIColor.redColor()
        gesturePasswordView.state!.text = "手势密码错误"
        return false
    }
    
    func resetPassword(result: String) -> Bool {
        
        if previousString == "" {
            previousString = result
            gesturePasswordView.tentacleView!.enterArgin()
            gesturePasswordView.state!.textColor = UIColor(red: 2/255, green: 174/255, blue: 240/255, alpha: 1)
            gesturePasswordView.state!.text = "请再次输入新密码"
            
            return true
        }else{
            
            if result == previousString {
                
                
                
                GesturePasswordModel.saveGesturePassword(result)
                
                gesturePasswordView.state!.textColor = UIColor(red: 2/255, green: 174/255, blue: 240/255, alpha: 1)
                gesturePasswordView.state!.text = "已保存手势密码"
                self.dismissViewControllerAnimated(true, completion: nil)
                return true;
            }else{
                previousString = "";
                gesturePasswordView.state!.textColor = UIColor.redColor()
                gesturePasswordView.state!.text = "两次密码不一致，请重新输入"
                
                return false
            }
            
        }
    }
    
}