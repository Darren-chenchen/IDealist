//
//  IDToastTestController.swift
//  IdealDemo
//
//  Created by darren on 1.5018/8/31.
//  Copyright © 1.5018年 陈亮陈亮. All rights reserved.
//

import UIKit

class IDToastTestController: IDBaseViewController {

    lazy var textF: UITextField = {
        let text = UITextField.init(frame: CGRect.zero)
        return text
    }()
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x:0,y:KNavgationBarHeight,width:KScreenWidth,height:KScreenHeight-40-100-KNavgationBarHeight), style: .plain)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.estimatedRowHeight = 60
        tableView.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
        return tableView
    }()
    lazy var bottomView: UIView = {
        let bottom  = UIView.init(frame: CGRect.init(x: 50, y: KScreenHeight-80, width: KScreenWidth-100, height: 80))
        bottom.backgroundColor = UIColor.groupTableViewBackground
        return bottom
    }()
    
    var sectionTitle = ["默认效果展示", "可扩展的属性"]
    
    // 默认效果展示
    var titleArr = ["展示纯文本",
                    "纯文本文字较多的情况",
                    "展示有图片的成功消息",
                    "展示有图片的失败消息",
                    "默认出现在界面中间",
    ]
    // 可扩展的属性
    var titleArr2 = [
        "展示纯文本，在指定view上。指定3s",
        "顶部出现",
        "底部出现",
        "底部出现，键盘弹出，文字自动上移",
        "更换toast背景色、字体颜色、字体大小、圆角大小、图片资源",
        "重置toast的属性",
        "禁止多任务顺序执行，连续点击，只toast一次"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.id_navTitle = "Toast组件使用介绍"
        self.view.addSubview(self.textF)
        self.view.addSubview(tableView)
        self.view.addSubview(self.bottomView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: - UITableViewDelegate,UITableViewDataSource
extension IDToastTestController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return titleArr.count
        }
        return titleArr2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ID = "ID"
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: ID)
        }
        if indexPath.section == 0 {
            cell?.textLabel?.text = titleArr[indexPath.row]
        }
        if indexPath.section == 1 {
            cell?.textLabel?.text = titleArr2[indexPath.row]
        }
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell?.textLabel?.numberOfLines = 0
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionTitle[section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                IDToast.id_show(msg: "展示纯文本")
            } else if indexPath.row == 1 {
                IDToast.id_show(msg: "测试纯文本文字较多的情况, 展示纯文本，在window上默认1.5s展示纯文本，在window上默认1.5s展示纯文本，在window上默认1.5s展示纯文本，在window上默认1.5s展示纯文本，在window上默认1.5s展示纯文本，在window上默认1.5s展示纯文本，在window上默认1.5s展示纯文本，在window上默认1.5s展示纯文本，在window上默认1.5s展示纯文本，在window上默认1.5s展示纯文本，在window上默认1.5s")
            }else if indexPath.row == 2 {
                IDToast.id_show(msg: "提交成功", success: .success)
            }
            else if indexPath.row == 3 {
                IDToast.id_show(msg: "提交失败", success: .fail)
            }
            else if indexPath.row == 4 {
                IDToast.id_show(msg: "展示在中间")
            }
        }
        
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                IDToast.id_show(msg: "测试展示在指定的view上", onView: self.bottomView, duration: 3)
            } else if indexPath.row == 1 {
                IDToast.id_show(msg: "测试顶部出现", position: IDToastPosition.top)
            } else if indexPath.row == 2 {
                IDToast.id_show(msg: "测试底部出现", position: IDToastPosition.bottom)
            } else if indexPath.row == 3 {
                IDToast.id_show(msg: "测试底部出现", duration: 8, position: IDToastPosition.bottom)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.textF.becomeFirstResponder()
                }
            } else if indexPath.row == 4 {
                IDToastManager.share.successImage = UIImage(named: "message_success")
                IDToastManager.share.textFont = UIFont.boldSystemFont(ofSize: 20)
                IDToastManager.share.textColor = UIColor.red
                IDToastManager.share.bgColor = UIColor(white: 0, alpha: 0.5)
                IDToastManager.share.cornerRadius = 8
                IDToast.id_show(msg: "修改toast的属性,修改toast的属性", success: .success)
            } else if indexPath.row == 5 {
                IDToastManager.share.id_resetDefaultProps()
                IDToast.id_show(msg: "重置toast的属性", success: .success)
            } else if indexPath.row == 6 {
                IDToastManager.share.supportQuene = false
                IDToast.id_show(msg: "测试禁止多任务顺序执行", success: .success)
            }
        }
    }
}
