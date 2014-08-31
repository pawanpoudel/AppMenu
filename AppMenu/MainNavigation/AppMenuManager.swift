//
//  AppMenuManager.swift
//  AppMenu
//
//  Created by Pawan Poudel on 8/30/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

import Foundation
import UIKit

class AppMenuManager {
    var menuItemsReader: MenuItemsReader?
    var menuItemBuilder: MenuItemBuilder?
    
    func menuViewController() -> MenuViewController? {
        let (metadata, metadataError) = menuItemsReader!.readMenuItems()
        
        if metadataError != nil {
            tellUserAboutError(metadataError!)
        }
        else if let menuItems = menuItemsFromMetadata(metadata!) {
            return menuViewControllerFromMenuItems(menuItems)
        }
        
        return nil
    }
    
    private func tellUserAboutError(error: NSError) {
        println("Error domain: \(error.domain)")
        println("Error code: \(error.code)")
        
        let alert = UIAlertView(title: "Error",
                                message: error.localizedDescription,
                                delegate: nil,
                                cancelButtonTitle: nil,
                                otherButtonTitles: "OK")
        alert.show()
    }
    
    private func menuItemsFromMetadata(metadata: [[String : String]]) -> [MenuItem]? {
        let (menuItems, builderError) = menuItemBuilder!.buildMenuItemsFromMetadata(metadata)
        
        if builderError != nil {
            tellUserAboutError(builderError!)
        }
        else {
            return menuItems
        }
        
        return nil
    }
    
    private func menuViewControllerFromMenuItems(menuItems: [MenuItem]) -> MenuViewController {
        let dataSource = MenuTableDefaultDataSource()
        dataSource.menuItems = menuItems
        
        let menuViewController = MenuViewController()
        menuViewController.dataSource = dataSource
        
        return menuViewController
    }
}