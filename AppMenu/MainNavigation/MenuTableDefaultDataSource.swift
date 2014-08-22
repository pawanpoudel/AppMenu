//
//  MenuTableDefaultDataSource.swift
//  AppMenu
//
//  Created by Pawan Poudel on 8/24/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

import Foundation
import UIKit

class MenuTableDefaultDataSource : NSObject, MenuTableDataSource {
    var menuItems: [MenuItem]?
    
    func setMenuItems(menuItems: [MenuItem]) {
        self.menuItems = menuItems
    }
    
    // MARK: - UITableView data source methods
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView!,
                   numberOfRowsInSection section: Int)
                   -> Int
    {
        return menuItems!.count
    }
    
    func tableView(tableView: UITableView!,
        cellForRowAtIndexPath indexPath: NSIndexPath!)
        -> UITableViewCell!
    {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: nil)
        let menuItem = menuItems?[indexPath.row]
        cell.textLabel.text = menuItem?.title
        return cell
    }
    
    // MARK: - UITableView delegate methods
    
    func tableView(tableView: UITableView!,
        didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
        let menuItem = menuItems?[indexPath.row]
        let notification = NSNotification(name: MenuTableDataSourceDidSelectItemNotification,
                                          object:menuItem)
        NSNotificationCenter.defaultCenter().postNotification(notification)
    }
}
