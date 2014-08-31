//
//  AppDelegate.swift
//  AppMenu
//
//  Created by PAWAN POUDEL on 8/16/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?

    func application(application: UIApplication!,
                     didFinishLaunchingWithOptions launchOptions: NSDictionary!)
                     -> Bool
    {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let navController = UINavigationController(rootViewController: MenuViewController())
        window!.rootViewController = navController
        
        window!.makeKeyAndVisible()
        return true
    }
}

