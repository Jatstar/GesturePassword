//
//  ViewController.swift
//  GesturePassword
//
//  Created by 张建宇 on 16/3/14.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var listData :[String] = ["手势密码"]{
        didSet{
        tableView.reloadData()
        }
    }
    
    let CellReuseIdentifier = "CellReuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: CellReuseIdentifier)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if GesturePasswordModel.existGesturePassword(){
            listData = ["手势密码","修改手势密码","alertView测试"]
        }else{
            listData = ["手势密码"]
        }
    }
    
    func passwordAction(sender:UISwitch){
        let vc = GesturePasswordControllerViewController()
        if !sender.on{
            vc.type = VerifyType.ToClean
        }
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
}

extension ViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCellWithIdentifier(CellReuseIdentifier, forIndexPath: indexPath)
        cell.textLabel?.text = listData[indexPath.row]
        if indexPath.row == 0{
            let swich = UISwitch()
            swich.on = GesturePasswordModel.existGesturePassword()
            swich.addTarget(self, action: #selector(ViewController.passwordAction(_:)), forControlEvents: .ValueChanged)
            cell.accessoryView = swich
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        switch indexPath.row {
        case 0:
            break
        case 2:
            let alertView = UIAlertView.init(title: "测试", message: "测试", delegate: nil, cancelButtonTitle: "取消")
            alertView.show()
            break
        default:
            break
            
        }
        
        
        
        
        if indexPath.row == 1{
            let vc = GesturePasswordControllerViewController()
            vc.type = VerifyType.ToChange
            self .presentViewController(vc, animated: true, completion: nil)
        }
    }
}

