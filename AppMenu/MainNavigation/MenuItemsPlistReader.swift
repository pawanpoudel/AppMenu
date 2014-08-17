//
//  MenuItemsPlistReader.swift
//  AppMenu
//
//  Created by Pawan Poudel on 8/17/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

import Foundation

class MenuItemsPlistReader: MenuItemsReader {
    var plistToReadFrom: String? = nil
    
    func readMenuItems() -> ([[String : String]]?, NSError?) {
        let error = NSError(domain: "Some domain", code: 0, userInfo: nil)
        return ([], error)
    }
}

