//
//  ViewController.swift
//  IdealDemo
//
//  Created by darren on 2018/8/31.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit

class MainViewController: IDBaseViewController {
    
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
    
    let dataArr = ["对话框组件 IDDialog", "轻提示组件 IDToast", "加载框组件 IDLoading", "空状态组件 IDEmptyView", "图片选择组件 IDImagePicker", "扫描二维码组件 IDScanCode", "基础控制器 IDBaseViewController"]
    let imageArr = ["icn_icn_dialog", "icn_icn_toast", "icn_icn_loading", "icn_icn_refresh", "icn_icn_emptyview", "icn_icn_update", "icn_icn_image", "icn_icn_scanning", "icn_icn_view"]
    
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
extension MainViewController:UITableViewDelegate,UITableViewDataSource{
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
            let vc = IDDialogTestController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.section == 1 {
            let vc = IDToastTestController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.section == 2 {
            let vc = IDLoadingTestViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
//        if indexPath.section == 3 {
//            let vc = TestIDRefreshController()
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
        if indexPath.section == 3 {
            let vc = TestIDEmptyViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
//        if indexPath.section ==  {
//            let vc = IDUpdateManagerTestController()
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
        if indexPath.section == 4 {
            let vc = TestIDImagePickerViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.section == 5 {
            let vc = TestIDScanCodeViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.section == 6 {
            let vc = TestIDBaseViewController()
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





