//
//  MenuItem.swift
//  AppMenu
//
//  Created by Pawan Poudel on 8/23/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

import Foundation

class MenuItem {
    let title: String
    var subTitle: String?
    var iconName: String?
    var tapHandlerName: String?
    
    init(title: String) {
        self.title = title
    }
}