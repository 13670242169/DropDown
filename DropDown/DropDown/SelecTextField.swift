//
//  SelecTextField.swift
//  DropDown
//
//  Created by 高级iOS开发 on 2017/12/3.
//  Copyright © 2017年 Apple. All rights reserved.
//

import UIKit

class SelecTextField: UIView {
    /*----------------------外部访问--------------------------*/
    /// textField里面的文本内容
    var text:String?
    /// 设置下拉选项提示按钮位置
    
    /// 设置textField的样式
    
    /// 设置textField的占位文字
    
    
    /*------------------私有属性,外部无权访问--------------------*/
    fileprivate var ShowDataArr : [Any]?
    fileprivate var textField:UITextField?
    fileprivate var MenuRect:CGRect?
    fileprivate var btn:UIButton?
    fileprivate var tempBtn:UIButton?
    fileprivate var me = Menu()
    fileprivate var textFieldHeight:CGFloat = 30
    fileprivate var listViewHeight:CGFloat = 120
    
    class func textFieldSelectValues(rect:CGRect,arr:[Any],listViewHeight:CGFloat = 150,placeHolder:String?) ->SelecTextField {
        let tf = SelecTextField(frame: rect)
        tf.height = tf.textFieldHeight
        tf.listViewHeight = listViewHeight
        tf.ShowDataArr = arr
        tf.MenuRect = CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: tf.listViewHeight)
        tf.textField?.placeholder = placeHolder
        return tf
    }
    fileprivate override init(frame: CGRect) {
        super.init(frame: frame)

        let tfrect =  CGRect(x: 0, y: 0, width: frame.width, height: textFieldHeight)
        textField = UITextField(frame: tfrect)
        textField?.layer.borderWidth = 1
        btn = UIButton(type: .custom)
        btn?.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        btn?.setImage(UIImage(named:"向上"), for: [])
        btn?.setImage(UIImage(named:"xiangxia (1)"), for: .selected)
        btn?.addTarget(self, action: #selector(btnclick), for: .touchUpInside)
        textField?.rightView = btn
        textField?.rightViewMode = .always
        textField?.layer.borderColor = UIColor.black.cgColor
        textField?.addTarget(self, action: #selector(textFieldclick), for: .editingDidBegin)
        textField?.borderStyle = .roundedRect
        textField?.delegate = self
        tempBtn = btn
        tempBtn?.isSelected = false
        addSubview(textField!)
    }
    @objc fileprivate func btnclick(btn:UIButton){
        self.height = textFieldHeight  + listViewHeight
        me.packUpMenu()
        if btn.isSelected == true {
            btn.isSelected = false
        }else{
            btn.isSelected = true
            textFieldclick(textField: self.textField!)
        }
    }
    @objc fileprivate func textFieldclick(textField:UITextField){
        self.height = textFieldHeight  + listViewHeight
        me.packUpMenu()
        btn?.isSelected = true
        guard
        let x = self.textField?.frame.minX,
        let y = self.textField?.frame.maxY,
        let w = self.textField?.frame.width,
        let h = MenuRect?.height
             else{
                return
        }
        let rect = CGRect(x: x, y:y, width: w ,height: h)
        me = Menu.initMenu(rect: rect,showArr:ShowDataArr!) {[unowned self] (index) in
            print(index)
            textField.resignFirstResponder()
            self.btn?.isSelected = false
            textField.text = self.ShowDataArr?[index] as? String
            self.text = textField.text
            self.textField?.isEnabled = true
            self.height = self.textFieldHeight
        }
        self.addSubview(me)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension SelecTextField:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.textField?.isEnabled = false
    }
}
