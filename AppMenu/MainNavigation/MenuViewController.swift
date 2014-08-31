//
//  MenuViewController.swift
//  AppMenu
//
//  Created by Pawan Poudel on 8/25/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var dataSource: MenuTableDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "didSelectMenuItemNotification:",
            name: MenuTableDataSourceDidSelectItemNotification,
            object: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self,
            name: MenuTableDataSourceDidSelectItemNotification,
            object: nil)
    }
    
    // MARK: - Notification handling
    
    func didSelectMenuItemNotification(notification: NSNotification?) {
        var menuItem: MenuItem? = notification!.object as? MenuItem
        
        if menuItem != nil {
            var tapHandler: UIViewController?
            
            switch menuItem!.tapHandlerName! {
                case "ContributionsViewController":
                tapHandler = ContributionsViewController()
                
                case "RepositoriesViewController":
                tapHandler = RepositoriesViewController()
                
                case "PublicActivityViewController":
                tapHandler = PublicActivityViewController()
                
                default:
                tapHandler = nil
            }
            
            if tapHandler != nil {
                self.navigationController.pushViewController(tapHandler, animated: true)
            }
        }
    }
}
