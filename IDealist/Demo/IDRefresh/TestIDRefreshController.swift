//
//  TestIDRefreshController.swift
//  IdealDemo
//
//  Created by implion on 2018/12/11.
//  Copyright © 2018 陈亮陈亮. All rights reserved.
//

import UIKit
    

class TestIDRefreshController: IDBaseViewController {

    var tableView: UITableView!
    
    var dataSources = ["1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1"] {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
        id_navTitle = "刷新组件"
        
        self.id_rightBtn.setTitle("结束", for: .normal)
        self.id_rightBtn.setTitleColor(UIColor.black, for: .normal)
    }
    
    override func rightBtnClick() {
//        tableView.id_header?.id_endRefreshing()
    }
    
    @objc func endRefreshing() {
//        tableView.id_header?.id_endRefreshing()
    }
    
    func configureTableView() {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        if #available(iOS 11.0, *) {
            tableView = UITableView(frame: CGRect(x: 0, y: 88, width: width, height: height - 88 - 34), style: .plain)
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
            //            tableView.insetsContentViewsToSafeArea = true
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
            // Fallback on earlier versions
        }
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
//        tableView.id_header = IDRefreshHeader {
//            print("Refresh")
//        }
        
//        IDRefresh.mainColor = ideal.share.mainColor ?? UIColor.white
        
//        tableView.id_footer = IDRefreshFooter {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//                self.dataSources += ["1", "1" , "1", "1", "1", "1"]
//                self.tableView.id_footer?.id_endRefreshing()
//                self.tableView.reloadData()
//                if self.dataSources.count > 30 {
//                    self.tableView.id_footer?.id_endRefreshingWithNoMoreData()
//                }
//            })
//        }
        
        tableView.tableFooterView = UIView()
    }
}

//MARK: - UITableViewDataSource
extension TestIDRefreshController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "exampleCell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "exampleCell")
        }
        cell?.textLabel?.text = "第 \(indexPath.row+1) 个 cell"
        return cell!
    }
}

extension TestIDRefreshController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
