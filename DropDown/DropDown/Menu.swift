//
//  Menu.swift
//  swiwiwi
//
//  Created by QYP on 2017/3/30.
//  Copyright © 2017年 QYP. All rights reserved.


import UIKit
class Menu: UIView{
    var ShowTableView: UITableView?
    var ShowDataArr : [Any]?
    let cellIdentifier = "cellID"

    var didSelectIndex:((_ index:Int)->Void)?

    var ShowTableSize : CGSize?
    class func initMenu(rect:CGRect,showArr:[Any],didSelect:((_ index:Int)->Void)?)->Menu{
        let frame = rect
        let me = Menu.init(frame:frame)
        me.ShowTableSize = me.frame.size
        let point = CGPoint(x:frame.origin.x,y: frame.origin.y)
        me.popupMenu(orginPoint:point, arr: showArr)
        me.didSelectIndex = {(index:Int) in
            didSelect!(index)
        }
        return me
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 8
        self.backgroundColor = UIColor.white
        ShowTableView = UITableView.init(frame: CGRect(x:0,y:0,width:frame.size.width,height:0), style: .plain)
        ShowTableView?.tableFooterView = UIView.init()
        ShowTableView?.delegate = self
        ShowTableView?.dataSource = self
        ShowTableView?.layer.cornerRadius = 8
        ShowTableView?.bounces = false
        addSubview(ShowTableView!)
        ShowTableView?.isHidden = true
        isHidden = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func popupMenu(orginPoint:CGPoint,arr : Array<Any>){
        self.isHidden = false
        ShowTableView?.isHidden = false
        self.frame.origin = orginPoint
        self.ShowDataArr = arr
        self.ShowTableView?.reloadData()
        self.superview?.bringSubview(toFront: self)
        self.frame.size.height = (self.ShowTableSize!.height)
        self.ShowTableView?.frame.size.height = (self.ShowTableSize!.height)
    }
    func packUpMenu() {
        self.ShowTableView?.frame.size.height = 0.0
        self.frame.size.height = 0.0
        self.isHidden = true
        self.ShowTableView?.isHidden = true
    }
}
extension Menu:UITableViewDelegate,UITableViewDataSource  {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ((ShowDataArr?.count) != nil) {
            return (ShowDataArr?.count)!
        }
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: cellIdentifier)
        }
        cell?.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.00)
        cell?.textLabel?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cell?.textLabel?.text = ShowDataArr?[indexPath.row] as? String
        cell?.textLabel?.textAlignment = .left
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 11.0)
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 30
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
       
        if (self.didSelectIndex != nil) {
            self.didSelectIndex!(indexPath.row)
        }
        self.packUpMenu()
    }
}
/*
class MunuCell:UITableViewCell{
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
*/
