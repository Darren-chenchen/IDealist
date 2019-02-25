//
//  IDDialogBaseViewController.swift
//  IdealDemo
//
//  Created by darren on 2018/11/23.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit

class IDDialogBaseViewController: IDBaseViewController {

    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x:0,y:KNavgationBarHeight,width:KScreenWidth,height:KScreenHeight-KNavgationBarHeight), style: .plain)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        return tableView
    }()
    
    var titleArr = ["标题+内容+2个按钮",
                    "标题+内容+1个按钮",
                    "标题+内容+1个按钮",
                    "内容+1个按钮",
                    "内容+2个按钮",
                    "标题+内容很多+居中",
                    "标题+内容很多+居左",
                    "设置主题色，2个按钮时只设置右边的主题色，1个按钮时显示主题色",
                    "禁止动画显示",
                    "打开动画显示",
                    "自定义动画",
                    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.tableView)
        self.id_navTitle = "基本使用"
    }

}

//MARK: - UITableViewDelegate,UITableViewDataSource
extension IDDialogBaseViewController:UITableViewDelegate,UITableViewDataSource{
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
            IDDialog.id_show(title: "温馨提示", msg: "确定要取消？", leftActionTitle: "确定", rightActionTitle: "取消", leftHandler: {
                print("点击了左边")
            }) {
                print("点击了右边")
            }
        } else if indexPath.row == 1 {
            IDDialog.id_show(title: "温馨提示", msg: "确定要取消？", leftActionTitle: "确定", rightActionTitle: nil, leftHandler: {
            }) {
            }
        }else if indexPath.row == 2 {
            IDDialog.id_show(title: "温馨提示", msg: "确定要取消？", leftActionTitle: "", rightActionTitle: "确定", leftHandler: {
            }) {
            }
        } else if indexPath.row == 3 {
            IDDialog.id_show(title: nil, msg: "确定要取消？", leftActionTitle: "", rightActionTitle: "确定", leftHandler: {
            }) {
            }
        } else if indexPath.row == 4 {
            IDDialog.id_show(title: nil, msg: "确定要取消？", leftActionTitle: "取消", rightActionTitle: "确定", leftHandler: {
            }) {
            }
        } else if indexPath.row == 5 {
            IDDialog.id_show(title: "温馨提示", msg: "内容较多内容较多内容较多内容较多内容较多内容较多内容较多内容较多内容较多内容较多内容较多内容较多内容较多内容较多内容较多内容较多内容较多内容较多内容较多内容较多123居中显示", leftActionTitle: "取消", rightActionTitle: "确定", leftHandler: {

            }) {

            }
        } else if indexPath.row == 6 {
            IDDialogManager.share.textAlignment = .left
            IDDialog.id_show(title: "温馨提示", msg: "内容较多内容较多内容较多内容较多内容较多内容较多内容较多内容较多内容较多内容较多内容较多内容较多内容较多内容较多内容较多内容较多内容较多内容较多内容较多内容较多123居左显示", leftActionTitle: "取消", rightActionTitle: "确定", leftHandler: {
                IDDialogManager.share.textAlignment = .center
            }) {
                IDDialogManager.share.textAlignment = .center
            }
        } else if indexPath.row == 7 {
            IDDialogManager.share.mainColor = UIColor.red
            IDDialog.id_show(title: "温馨提示", msg: "设置主题色", leftActionTitle: "取消", rightActionTitle: "确定", leftHandler: {
            }) {
            }
        } else if indexPath.row == 8 {
            IDDialogManager.share.supportAnimate = false
            IDDialog.id_show(title: "温馨提示", msg: "禁止动画", leftActionTitle: "取消", rightActionTitle: "确定", leftHandler: {
                IDDialogManager.share.supportAnimate = true
            }) {
                IDDialogManager.share.supportAnimate = true
            }
        } else if indexPath.row == 9 {
            IDDialogManager.share.supportAnimate = true
            IDDialog.id_show(title: "温馨提示", msg: "打开动画", leftActionTitle: "取消", rightActionTitle: "确定", leftHandler: {
            }) {
            }
        } else if indexPath.row == 10 {
            let shakeAnimation = CABasicAnimation.init(keyPath: "position")
            shakeAnimation.duration = 0.2
            shakeAnimation.fromValue = NSValue.init(cgPoint: CGPoint.init(x: KScreenWidth*0.5, y: 0))
            shakeAnimation.toValue = NSValue.init(cgPoint: CGPoint.init(x: KScreenWidth*0.5, y: KScreenHeight*0.5))
            shakeAnimation.autoreverses = false
            IDDialogManager.share.animate = shakeAnimation
            IDDialog.id_show(title: "温馨提示", msg: "自定义动画", leftActionTitle: "取消", rightActionTitle: "确定", leftHandler: {
                IDDialogManager.share.id_resetSetupAnimation()
            }) {
                IDDialogManager.share.id_resetSetupAnimation()
            }
        }
    }
}


