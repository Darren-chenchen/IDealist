//
//  ViewController.swift
//  IdealDemo
//
//  Created by darren on 2018/8/31.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit

class UIKitViewController: IDBaseViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x:0,y:KNavgationBarHeight,width:KScreenWidth,height:KScreenHeight-KNavgationBarHeight-KTabBarHeight), style: .grouped)
        tableView.tableHeaderView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0.1))
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 64
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.rowHeight = 64
        return tableView
    }()
    
    let dataArr = ["按钮 IDButton", "文本 IDLabel", "图片 IDImage", "气泡 IDPopView","文本输入框 IDTextField", "多行文本输入框 IDTextView", "搜索框 IDSearchBar","开关按钮IDSwitch","选择控件 IDSegmentedControl", "进度条 IDProgressView"]
    let imageArr = ["icn_icn_button", "icn_icn_label", "icn_icn_image", "icn_icn_popview", "icn_icn_textfield", "icn_icn_textview", "icn_icn_searchbar", "icn_icn_switch", "icn_icn_segmentview", "icn_icn_progressview"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
        self.tableView.contentInset = UIEdgeInsets.init(top: 10, left: 0, bottom: 0, right: 0)
        self.id_navTitle = "IDealist"
        self.id_rightBtn.setImage(UIImage(named: "icn_icn_imfomation"), for: .normal)
    }
    override func rightBtnClick() {
        let vc = IDInfoViewController.init(nibName: "IDInfoViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UITableViewDelegate,UITableViewDataSource
extension UIKitViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArr.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = HomeListCell.cellWithTableView(tableView: tableView)
        cell.titleLabel.text = self.dataArr[indexPath.section]
        cell.iconView.image = UIImage(named: self.imageArr[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            let vc = TestButtonViewController.init(nibName: "TestButtonViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.section == 1 {
            let vc = TestLabelViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.section == 2 {
            let vc = TestImageViewController()
            self.navigationController?.pushViewController(vc, animated: true)
           
        }
        if indexPath.section == 3 {
            let vc = TestIDPopViewController.init(nibName: "TestIDPopViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.section == 4 {
            let vc = TestTextFieldViewController.init(nibName: "TestTextFieldViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.section == 5 {
            let vc = TestTextViewControllerTwo()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.section == 6 {
            let vc = TestSearchBarViewController.init(nibName: "TestSearchBarViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        if indexPath.section == 7 {
            let vc = TestSwitchViewController.init(nibName: "TestSwitchViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        if indexPath.section == 8 {
            let vc = TestIDSegmentedViewController.init(nibName: "TestIDSegmentedViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.section == 9 {
            let vc = TestProgressViewController.init(nibName: "TestProgressViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
}





