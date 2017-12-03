//
//  SelecTextField.swift
//  DropDown
//
//  Created by 高级iOS开发 on 2017/12/3.
//  Copyright © 2017年 Apple. All rights reserved.
//

import UIKit

class SelecTextField: UIView {
    var ShowDataArr : [Any]?
    var textField:UITextField?
    var tfRect:CGRect?
    class func textFieldSelectValues(rect:CGRect,arr:[Any]) ->SelecTextField {
        let rect = rect
        let tf = SelecTextField(frame: rect)
        tf.ShowDataArr = arr
        tf.tfRect = rect
        return tf
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.red
        let tfrect =  CGRect(x: 0, y: 0, width: frame.width, height: 30)
        textField = UITextField(frame: tfrect)
        textField?.layer.borderWidth = 1
        textField?.layer.borderColor = UIColor.black.cgColor
        textField?.addTarget(self, action: #selector(click(textField:)), for: .editingDidBegin)
        textField?.borderStyle = .roundedRect
        addSubview(textField!)
    }
    @objc func click(textField:UITextField){
        let h = (self.tfRect?.height)! - textField.height
        let rect = CGRect(x: textField.x, y: textField.y + textField.height, width: textField.width, height: h)
        let me = Menu.initMenu(rect: rect,showArr:ShowDataArr!) { (index) in
            print(index)
            textField.resignFirstResponder()
            
        }
        self.addSubview(me)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
