//
//  ObjectConfigurator.swift
//  AppMenu
//
//  Created by Pawan Poudel on 9/1/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

import UIKit

class ObjectConfigurator {
    func appMenuManager() -> AppMenuManager {
        let appMenuManager = AppMenuManager()
        let menuItemsPlistReader = MenuItemsPlistReader()
        
        menuItemsPlistReader.plistToReadFrom = "menuItems"
        appMenuManager.menuItemsReader = menuItemsPlistReader
        appMenuManager.menuItemBuilder = MenuItemDefaultBuilder()
        appMenuManager.objectConfigurator = self
        
        return appMenuManager
    }
    
    func menuViewController() -> MenuViewController {
        let menuViewController = MenuViewController(nibName: "MenuViewController",
                                                    bundle: nil)
        menuViewController.dataSource = MenuTableDefaultDataSource()
        menuViewController.tapHandlerBuilder = MenuItemTapHandlerBuilder()
        
        return menuViewController
    }
}
