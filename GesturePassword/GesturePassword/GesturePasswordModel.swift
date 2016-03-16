//
//  GesturePasswordModel.swift
//  GesturePassword
//
//  Created by 张建宇 on 16/3/16.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit

let secKey:String = "GesturePassword"

class GesturePasswordModel: NSObject {

    class func clear(){
        
        NSUserDefaults.standardUserDefaults().removeObjectForKey(secKey)
    }
    
    class func existGesturePassword() ->Bool {
        let password = NSUserDefaults.standardUserDefaults().objectForKey(secKey) as? String
        if password == nil || password == ""{
            return false
        }
            return true
    }
    
    class func saveGesturePassword(password:String) {
        NSUserDefaults.standardUserDefaults().setObject(password, forKey: secKey)
    }
    
    class func getGesturePassword() ->String? {
        return NSUserDefaults.standardUserDefaults().objectForKey(secKey) as? String
    }
    
}
