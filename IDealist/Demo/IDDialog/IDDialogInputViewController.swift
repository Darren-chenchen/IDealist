//
//  IDDialogBaseViewController.swift
//  IdealDemo
//
//  Created by darren on 2018/11/23.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit

class IDDialogInputViewController: IDBaseViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x:0,y:KNavgationBarHeight,width:KScreenWidth,height:KScreenHeight-KNavgationBarHeight), style: .plain)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        return tableView
    }()
    var titleArr = ["展示可输入文本的弹框",
                     "限制最大长度10",
                     "限制不可输入表情符号",
                     "只能输入数字和小数点，小数点后保留2位",
                     "只能输入数字和小数点，小数点后保留3位,最大长度限制10",
                     "自定义正则，只能输入数字和英文",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.tableView)
        self.id_navTitle = "Input属性介绍"
    }
    
}

//MARK: - UITableViewDelegate,UITableViewDataSource
extension IDDialogInputViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ID = "ID"
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: ID)
        }
        cell?.textLabel?.numberOfLines = 0
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell?.textLabel?.text = self.titleArr[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            IDDialog.id_showInput(msg: "请输入取消原因", leftActionTitle: "取消", rightActionTitle: "确定", leftHandler: { (text) in
                print(text)
            }) { (text) in
                print(text)
            }
        }
        if indexPath.row == 1 {
            IDDialogManager.share.maxLength = 10
            IDDialog.id_showInput(msg: "限制最大长度10", leftActionTitle: "取消", rightActionTitle: "确定", leftHandler: { (text) in
                print(text)
            }) { (text) in
                print(text)
            }
        }
        if indexPath.row == 2 {
            IDDialogManager.share.allowEmoji = false
            IDDialog.id_showInput(msg: "禁止输入表情符号", leftActionTitle: "取消", rightActionTitle: "确定", leftHandler: { (text) in
                print(text)
            }) { (text) in
                print(text)
            }
        }
        if indexPath.row == 3 {
            IDDialogManager.share.onlyNumberAndPoint = true
            IDDialogManager.share.pointLength = 2
            IDDialog.id_showInput(msg: "只能输入数字和小数点，小数点后保留2位", leftActionTitle: "取消", rightActionTitle: "确定", leftHandler: { (text) in
                print(text)
            }) { (text) in
                print(text)
            }
        }
        if indexPath.row == 4 {
            IDDialogManager.share.onlyNumberAndPoint = true
            IDDialogManager.share.pointLength = 3
            IDDialogManager.share.maxLength = 10
            IDDialog.id_showInput(msg: "只能输入数字和小数点，小数点后保留3位,最大长度限制10", leftActionTitle: "取消", rightActionTitle: "确定", leftHandler: { (text) in
                print(text)
            }) { (text) in
                print(text)
            }
        }
        if indexPath.row == 5 {
            IDDialogManager.share.predicateString = "^[a-z0－9A-Z]*$"
            IDDialog.id_showInput(msg: "自定义正则，只能输入数字和英文", leftActionTitle: "取消", rightActionTitle: "确定", leftHandler: { (text) in
                print(text)
            }) { (text) in
                print(text)
            }
        }
    }
}


