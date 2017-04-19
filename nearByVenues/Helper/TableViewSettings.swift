//
//  TableViewSettings.swift
//  nearByVenues
//
//  Created by janesh on 4/18/17.
//  Copyright © 2017 Jitendra Gaur. All rights reserved.
//

import UIKit

struct TableViewSettings {
    static func setUptable(tableView:UITableView,rowheight:CGFloat,estimatedRowheight:CGFloat){
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = rowheight
        
    }
    static func setUpCell(cell:UITableViewCell){
        cell.separatorInset = .zero
        cell.accessoryType = .disclosureIndicator


    }
}


