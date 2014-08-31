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
    
    // TODO: Write tests for each tap handler
    
    func testCorrectViewIsDisplayedWhenContributionsMenuItemIsTapped() {
        let menuItem = MenuItem(title: "Contributions")
        menuItem.tapHandlerName = "ContributionsViewController"
        
        let notification = NSNotification(name: MenuTableDataSourceDidSelectItemNotification, object: menuItem)
        menuViewController?.didSelectMenuItemNotification(notification)
        let topViewController = navController?.topViewController
        
        XCTAssertTrue(topViewController!.isKindOfClass(ContributionsViewController),
            "Contributions view is displayed for Contributions menu item")
    }
    
    func testCorrectViewIsDisplayedWhenRepositoriesMenuItemIsTapped() {
        let menuItem = MenuItem(title: "Repositories")
        menuItem.tapHandlerName = "RepositoriesViewController"
        
        let notification = NSNotification(name: MenuTableDataSourceDidSelectItemNotification, object: menuItem)
        menuViewController?.didSelectMenuItemNotification(notification)
        let topViewController = navController?.topViewController
        
        XCTAssertTrue(topViewController!.isKindOfClass(RepositoriesViewController),
            "Repositories view is displayed for Contributions menu item")
    }
    
    func testCorrectViewIsDisplayedWhenPublicActivityMenuItemIsTapped() {
        let menuItem = MenuItem(title: "PublicActivity")
        menuItem.tapHandlerName = "PublicActivityViewController"
        
        let notification = NSNotification(name: MenuTableDataSourceDidSelectItemNotification, object: menuItem)
        menuViewController?.didSelectMenuItemNotification(notification)
        let topViewController = navController?.topViewController
        
        XCTAssertTrue(topViewController!.isKindOfClass(PublicActivityViewController),
            "Public activity view is displayed for Contributions menu item")
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
