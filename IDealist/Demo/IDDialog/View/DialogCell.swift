//
//  DialogCell.swift
//  IdealDemo
//
//  Created by darren on 2018/11/23.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit

typealias clickSwichCluse = () -> ()
typealias clickDetailCluse = () -> ()

class DialogCell: UITableViewCell {
    
    var swichClouse: clickSwichCluse?
    var detailClouse: clickDetailCluse?

    @IBOutlet weak var swich: UISwitch!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func clickSwich(_ sender: Any) {
        if self.swich.isOn {
            if swichClouse != nil {
                swichClouse!()
            }
        } else {
            
        }
    }
    @IBAction func clickBtn(_ sender: Any) {
        if detailClouse != nil {
            detailClouse!()
        }
    }
    static func cellWithTableView(tableView:UITableView) -> DialogCell{
        let bundle = Bundle.main
        let ID = "DialogCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = bundle.loadNibNamed("DialogCell", owner: nil, options: nil)?.last as! DialogCell?
        }
        cell?.selectionStyle = .none
        
        return cell! as! DialogCell
    }
    

    
}
