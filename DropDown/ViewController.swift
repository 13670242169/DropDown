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
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func show(_ sender: UIButton) {
        let arr = ["0","1","2","3","4","5"]
        let rect = CGRect(x: sender.x, y: sender.y + sender.height, width: sender.width, height: 100)
        let me = Menu.initMenu(rect: rect,showArr:arr) { (index) in
            print(index)
            sender.titleLabel?.text = "\(index)"
        }
        self.view.addSubview(me)
    }

}

