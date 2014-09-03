//
//  MenuItemTapHandlerBuilder.swift
//  AppMenu
//
//  Created by Pawan Poudel on 9/1/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

import UIKit

class MenuItemTapHandlerBuilder {
    func tapHandlerForMenuItem(menuItem: MenuItem?) -> UIViewController? {
        var tapHandler: UIViewController?
        
        if menuItem != nil {
            switch menuItem!.tapHandlerName! {
            case "ContributionsViewController":
                tapHandler =
                    ContributionsViewController(
                        nibName: "ContributionsViewController",
                        bundle: nil)
                
            case "RepositoriesViewController":
                tapHandler =
                    RepositoriesViewController(
                        nibName: "RepositoriesViewController",
                        bundle: nil)
                
            case "PublicActivityViewController":
                tapHandler = PublicActivityViewController(
                    nibName: "PublicActivityViewController",
                    bundle: nil)
                
            default:
                tapHandler = nil
            }
        }
        
        return tapHandler
    }
}
