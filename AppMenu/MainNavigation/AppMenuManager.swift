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
    var menuItemsReader: MenuItemsReader? = nil
    var menuItemBuilder: MenuItemBuilder? = nil
    var objectConfigurator: ObjectConfigurator? = nil
    
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
            return nil
        }

        return menuItems
    }
    
    private func menuViewControllerFromMenuItems(menuItems: [MenuItem]) -> MenuViewController {
        let menuViewController = objectConfigurator?.menuViewController()
        let dataSource = menuViewController!.dataSource
        dataSource?.setMenuItems(menuItems)
        
        return menuViewController!
    }
}
