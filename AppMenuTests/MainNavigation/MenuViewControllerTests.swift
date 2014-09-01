//
//  MenuViewControllerTests.swift
//  AppMenu
//
//  Created by Pawan Poudel on 8/25/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

import UIKit
import XCTest

let postedNotification = "MenuViewControllerTestsPostedNotification"

class MenuViewControllerTests: XCTestCase {
    var menuViewController: MenuViewController?
    var dataSource: MenuTableDataSource?
    var tableView: UITableView?
    var navController: UINavigationController?
    
    override func setUp() {
        super.setUp()
        dataSource = MenuTableFakeDataSource()
        tableView = UITableView()
        
        menuViewController = MenuViewController()
        menuViewController?.dataSource = dataSource
        menuViewController?.tableView = tableView
        
        navController = UINavigationController(rootViewController: menuViewController)
        
        let appDelegate = UIApplication.sharedApplication().delegate
        let window = appDelegate.window
        
        appDelegate.window!?.rootViewController = navController
        window!?.makeKeyAndVisible()
    }

    override func tearDown() {
        super.tearDown()
        objc_removeAssociatedObjects(menuViewController)
    }
    
    func testCanBeAssignedADataSource() {
        XCTAssertTrue(dataSource!.isEqual(menuViewController?.dataSource),
            "A data source can be assigned to a menu view controller")
    }
    
    func testHasATableView() {
        XCTAssertTrue(tableView!.isEqual(menuViewController?.tableView),
            "Menu view controller has a table view")
    }
    
    func testTableViewIsGivenADataSourceInViewDidLoad() {
        menuViewController?.viewDidLoad()
        XCTAssertTrue(tableView!.dataSource.isEqual(dataSource),
            "Data source for the menu table view is set in viewDidLoad method")
    }
    
    func testTableViewIsGivenADelegateInViewDidLoad() {
        menuViewController?.viewDidLoad()
        XCTAssertTrue(tableView!.delegate.isEqual(dataSource),
            "Delegate for the menu table view is set in viewDidLoad method")
    }
    
    func testRegistrationForMenuItemTappedNotificationHappensInViewDidAppear() {
        swizzleNotificationHandler()
        
        menuViewController?.viewDidAppear(false)
        NSNotificationCenter.defaultCenter()
            .postNotificationName(MenuTableDataSourceDidSelectItemNotification,
                object: nil)
        
        XCTAssertNotNil(objc_getAssociatedObject(menuViewController, postedNotification),
            "Menu view controller listens to notification when it's view is visible")
    }
    
    func testRemovesItselfAsListenerForMenuItemTappedNotificationInViewDidDisappear() {
        swizzleNotificationHandler()
        
        menuViewController?.viewDidAppear(false)
        menuViewController?.viewDidDisappear(false)
        
        NSNotificationCenter.defaultCenter()
            .postNotificationName(MenuTableDataSourceDidSelectItemNotification,
                object: nil)
        
        XCTAssertNil(objc_getAssociatedObject(menuViewController, postedNotification),
            "Menu view controller removes iteself as listener for notification when view is not visible anymore")
    }
    
    func testCorrectViewIsDisplayedWhenContributionsMenuItemIsTapped() {
        let menuItem = MenuItem(title: "Contributions")
        menuItem.featureName = "contributions"
        let notification = NSNotification(name: MenuTableDataSourceDidSelectItemNotification,
                                          object: menuItem)
        
        menuViewController!.didSelectMenuItemNotification(notification)
        let topViewController = navController!.topViewController
        
        let isIt = topViewController is MenuViewController
        println("isIt: \(isIt)")
        
        let featureName = topViewController.valueForKey("featureName") as String
        
        XCTAssertEqual(featureName, "contributions",
            "Contributions view is displayed when the contributions menu item is tapped")
    }
    
    func testCorrectViewIsDisplayedWhenRepositoriesMenuItemIsTapped() {
        let menuItem = MenuItem(title: "Repositories")
        menuItem.featureName = "repositories"
        let notification = NSNotification(name: MenuTableDataSourceDidSelectItemNotification,
                                          object: menuItem)
        
        menuViewController?.didSelectMenuItemNotification(notification)
        let topViewController = navController?.topViewController
        
        let featureName = topViewController!.valueForKey("featureName") as String
        
        XCTAssertEqual(featureName, "repositories",
            "Repositories view is displayed when the repositories menu item is tapped")
    }
    
    func testCorrectViewIsDisplayedWhenPublicActivityMenuItemIsTapped() {
        let menuItem = MenuItem(title: "PublicActivity")
        menuItem.featureName = "publicActivity"
        let notification = NSNotification(name: MenuTableDataSourceDidSelectItemNotification,
                                          object: menuItem)
        
        menuViewController?.didSelectMenuItemNotification(notification)
        let topViewController = navController?.topViewController
        let featureName = topViewController!.valueForKey("featureName") as String
        
        XCTAssertEqual(featureName, "publicActivity",
            "Public activity view is displayed when the public activity menu item is tapped")
    }
    
    // Mark: - Method swizzling
    
    func swizzleNotificationHandler() {
        var realMethod: Method = class_getInstanceMethod(object_getClass(menuViewController),
            Selector.convertFromStringLiteral("didSelectMenuItemNotification:"))
        
        var testMethod: Method = class_getInstanceMethod(object_getClass(menuViewController), Selector.convertFromStringLiteral("testImpl_didSelectMenuItemNotification:"))
        
        method_exchangeImplementations(realMethod, testMethod)
    }    
}

extension MenuViewController {
    func testImpl_didSelectMenuItemNotification(notification: NSNotification) {
        objc_setAssociatedObject(self,
                                 postedNotification,
                                 notification,
                                 UInt(OBJC_ASSOCIATION_RETAIN))
    }
}
