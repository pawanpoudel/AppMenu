//
//  FakeMenuItemsReader.swift
//  AppMenu
//
//  Created by Pawan Poudel on 8/24/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

import Foundation

class FakeMenuItemsReader : MenuItemsReader {
    var missingTitle: Bool = false
    
    func readMenuItems() -> ([[String : String]]?, NSError?) {
        let menuItem1 = missingTitle ? menuItem1WithMissingTitle() : menuItem1WithNoMissingTitle()
        
        let menuItem2 = ["title": "Menu Item 2",
                         "subTitle": "Menu Item 2 subtitle",
                         "iconName": "iconName2"]
        
        return ([menuItem1, menuItem2], nil)
    }
    
    func menuItem1WithMissingTitle() -> [String : String] {
        return ["subTitle": "Menu Item 1 subtitle",
                "iconName": "iconName1"]
    }
    
    func menuItem1WithNoMissingTitle() -> [String : String] {
        var menuItem = menuItem1WithMissingTitle()
        menuItem["title"] = "Menu Item 2"
        return menuItem
    }
}
