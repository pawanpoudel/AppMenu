//
//  MenuTableDataSource.swift
//  AppMenu
//
//  Created by Pawan Poudel on 8/24/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

import UIKit

let MenuTableDataSourceDidSelectItemNotification = "MenuTableDataSourceDidSelectItemNotification"

protocol MenuTableDataSource : UITableViewDataSource, UITableViewDelegate {
    func setMenuItems(menuItems: [MenuItem])
}
