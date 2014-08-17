//
//  MenuItemsReader.swift
//  AppMenu
//
//  Created by Pawan Poudel on 8/17/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

import Foundation

protocol MenuItemsReader {
    func readMenuItems() -> ([[String : String]]?, NSError?)
}
