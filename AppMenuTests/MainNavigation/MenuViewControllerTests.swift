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
    
    override func setUp() {
        super.setUp()
        dataSource = MenuTableFakeDataSource()
        tableView = UITableView()
        
        menuViewController = MenuViewController()
        menuViewController?.dataSource = dataSource
        menuViewController?.tableView = tableView

        objc_removeAssociatedObjects(menuViewController)
    }

    override func tearDown() {
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
    
    // Mark: - Method swizzling
    
    func swizzleNotificationHandler() {
        var realMethod: Method = class_getInstanceMethod(object_getClass(menuViewController),
            Selector.convertFromStringLiteral("didSelectMenuItemNotification"))
        
        var testMethod: Method = class_getInstanceMethod(object_getClass(menuViewController), Selector.convertFromStringLiteral("testImpl_didSelectMenuItemNotification"))
        
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

