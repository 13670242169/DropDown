//
//  ViewController.swift
//  DropDown
//
//  Created by Apple on 2017/12/1.
//  Copyright © 2017年 Apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let rect = CGRect(x: 0, y: 100, width: 100, height: 30)
        let arr = ["0","1","2","3","4","5"]
        let tf = SelecTextField.textFieldSelectValues(rect: rect, arr: arr,placeHolder:"测试")
    
        self.view.addSubview(tf)
    }

    @IBAction func show(_ sender: UIButton) {
        let arr = ["0","1","2","3","4","5"]
        let rect = CGRect(x: sender.x, y: sender.y + sender.height, width: sender.width, height: 100)
        let me = MenuList.initMenuList(rect: rect,showArr:arr) { (index) in
            print(index)
            sender.setTitle("\(index)", for: [])
        }
        self.view.addSubview(me)
    }

}

