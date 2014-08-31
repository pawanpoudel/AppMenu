//
//  FakeMenuItemBuilder.swift
//  AppMenu
//
//  Created by Pawan Poudel on 8/30/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

import Foundation

class FakeMenuItemBuilder : MenuItemBuilder {
    var errorToReturn: NSError? = nil
    var menuItemsToReturn: [MenuItem]? = nil
    var metadata: [[String : String]]? = nil
    
    func buildMenuItemsFromMetadata(metadata: [[String : String]]) -> ([MenuItem]?, NSError?) {
        self.metadata = metadata
        return (menuItemsToReturn, errorToReturn)
    }
}
