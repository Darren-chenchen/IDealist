//
//  UtilsViewController.swift
//  IdealDemo
//
//  Created by darren on 2018/12/4.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit

class UtilsViewController: IDBaseViewController {

    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x:0,y:KNavgationBarHeight,width:KScreenWidth,height:KScreenHeight-KNavgationBarHeight-KTabBarHeight), style: .plain)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        return tableView
    }()
    
    var dataArr = ["统一设置组件库的主题颜色", "快速实现颜色设置", "获取App信息", "字符串截取封装函数", "日期封装", "UIView属性扩展", "Url特殊字符串处理", "数组去重"]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.id_navTitle = "公共方法、扩展方法集合"
        self.view.addSubview(tableView)
        self.id_rightBtn.setImage(UIImage(named: "icn_icn_imfomation"), for: .normal)
    }
    override func rightBtnClick() {
        let vc = IDInfoViewController.init(nibName: "IDInfoViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UITableViewDelegate,UITableViewDataSource
extension UtilsViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ID")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "ID")
        }
        cell?.accessoryType = .disclosureIndicator
        cell?.textLabel?.text = self.dataArr[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            let vc = IDUtilsThemeViewController.init(nibName: "IDUtilsThemeViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 1 {
            let vc = TestColorViewController.init(nibName: "TestColorViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 2 {
            let vc = TestAppInfoViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 3 {
            let vc = TestStringViewController.init(nibName: "TestStringViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 4 {
            let vc = TestDateViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 5 {
            let vc = TestIDViewViewController.init(nibName: "TestIDViewViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 6 {
            let vc = TestURLViewController.init(nibName: "TestURLViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 7 {
            let vc = TestArrayViewController.init(nibName: "TestArrayViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


