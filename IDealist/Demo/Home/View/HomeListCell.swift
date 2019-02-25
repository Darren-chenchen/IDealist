//
//  HomeListCell.swift
//  IdealDemo
//
//  Created by darren on 2018/11/23.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit

class HomeListCell: UITableViewCell {

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.groupTableViewBackground
        self.bottomView.layer.cornerRadius = 4
    }
    
    static func cellWithTableView(tableView:UITableView) -> HomeListCell{
        let bundle = Bundle.main
        let ID = "HomeListCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = bundle.loadNibNamed("HomeListCell", owner: nil, options: nil)?.last as! HomeListCell?
        }
        cell?.selectionStyle = .none
        
        return cell! as! HomeListCell
    }
    

}
