//
//  AppDelegateTests.swift
//  AppMenu
//
//  Created by Pawan Poudel on 9/1/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

import UIKit
import XCTest

class FakeAppMenuManager: AppMenuManager {
    override func menuViewController() -> MenuViewController? {
        return MenuViewController()
    }
}

class FakeObjectConfigurator : ObjectConfigurator {
    override func appMenuManager() -> AppMenuManager {
        return FakeAppMenuManager()
    }
}

class AppDelegateTests: XCTestCase {
    var window: UIWindow?
    var navController: UINavigationController?
    var appDelegate: AppDelegate?
    var objectConfigurator: ObjectConfigurator?
    var didFinishLaunchingWithOptionsReturnValue: Bool?
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        navController = UINavigationController()
        appDelegate = AppDelegate()
        appDelegate?.window = window
        appDelegate?.navController = navController
    }
    
    func testRootVCForWindowIsNotSetIfMenuViewControllerCannotBeCreated() {
        class FakeAppMenuManager: AppMenuManager {
            override func menuViewController() -> MenuViewController? {
                return nil
            }
        }
        
        class FakeObjectConfigurator : ObjectConfigurator {
            override func appMenuManager() -> AppMenuManager {
                return FakeAppMenuManager()
            }
        }
        
        appDelegate?.objectConfigurator = FakeObjectConfigurator()
        appDelegate?.application(nil, didFinishLaunchingWithOptions: nil)

        XCTAssertNil(window!.rootViewController,
            "Window's root view controller shouldn't be set if menu view controller can't be created")
    }
    
    func testWindowHasRootViewControllerIfMenuViewControllerIsCreated() {
        appDelegate?.objectConfigurator = FakeObjectConfigurator()
        appDelegate?.application(nil, didFinishLaunchingWithOptions: nil)
        XCTAssertEqual(window!.rootViewController, navController!,
            "App delegate's nav controller should be the root view controller")
    }
    
    func testMenuViewControllerIsRootVCForNavigationController() {
        appDelegate?.objectConfigurator = FakeObjectConfigurator()
        appDelegate?.application(nil, didFinishLaunchingWithOptions: nil)
        
        let topViewController = appDelegate?.navController?.topViewController
        XCTAssertTrue(topViewController is MenuViewController,
            "Menu view controlelr is root VC for nav controller")
    }
    
    func testWindowIsKeyAfterAppIsLaunched() {
        appDelegate?.application(nil, didFinishLaunchingWithOptions: nil)
        XCTAssertTrue(window!.keyWindow,
            "App delegate's window should be the key window for the app")
    }
    
    func testAppDidFinishLaunchingDelegateMethodAlwaysReturnsTrue() {
        didFinishLaunchingWithOptionsReturnValue =
            appDelegate?.application(nil, didFinishLaunchingWithOptions: nil)
        
        XCTAssertTrue(didFinishLaunchingWithOptionsReturnValue!,
            "Did finish launching delegate method should return true")
    }
}
