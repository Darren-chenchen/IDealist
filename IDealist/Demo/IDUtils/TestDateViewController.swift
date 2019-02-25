//
//  TestDateViewController.swift
//  Ideal-IOS
//
//  Created by darren on 2018/12/5.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit

class TestDateViewController: IDBaseViewController {
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x:0,y:KNavgationBarHeight,width:KScreenWidth,height:KScreenHeight-KNavgationBarHeight-KTabBarHeight), style: .plain)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        return tableView
    }()
    
    var dataArr = ["是否是今天:\(Date().id_isToday())",
        "是否是今年:\(Date().id_isThisYear())",
        "是否是昨天：\(Date().id_isYesterday())",
        "是否是3天内：\(Date().id_isBetween(dateNum: 3))",
        "日期格式化：\(Date().format("yyyy/MM/dd"))",
        "日期格式化开始时间：\(Date().start.format("yyyy/MM/dd HH:mm:ss"))",
        "日期格式化结束时间：\(Date().end.format("yyyy/MM/dd HH:mm:ss"))"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        self.id_navTitle = "日期封装"
        self.view.addSubview(self.tableView)
    }

}
//MARK: - UITableViewDelegate,UITableViewDataSource
extension TestDateViewController:UITableViewDelegate,UITableViewDataSource{
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
        cell?.accessoryType = .none
        cell?.textLabel?.text = self.dataArr[indexPath.row]
        cell?.textLabel?.numberOfLines = 0
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 1 {
        }
    }
}
