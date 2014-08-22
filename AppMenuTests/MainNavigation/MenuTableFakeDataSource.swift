//
//  MenuTableFakeDataSource.swift
//  AppMenu
//
//  Created by Pawan Poudel on 8/25/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

import Foundation
import UIKit

class MenuTableFakeDataSource : NSObject, MenuTableDataSource {
    func setMenuItems(menuItems: [MenuItem]) {
    }
    
    // MARK: - UITableView data source methods
    
    func tableView(tableView: UITableView!,
                   numberOfRowsInSection section: Int)
                   -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView!,
                   cellForRowAtIndexPath indexPath: NSIndexPath!)
                   -> UITableViewCell!
    {
        return nil
    }
}
