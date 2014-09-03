//
//  AppMenuManagerTests.swift
//  AppMenu
//
//  Created by Pawan Poudel on 8/30/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

import UIKit
import XCTest

class AppMenuManagerTests: XCTestCase {
    var menuManager: AppMenuManager?
    var fakeMenuItemsReader: FakeMenuItemsReader?
    var fakeMenuItemBuilder: FakeMenuItemBuilder?
    var menuViewController: MenuViewController?
    
    override func setUp() {
        super.setUp()
        menuManager = AppMenuManager()
        fakeMenuItemsReader = FakeMenuItemsReader()
        fakeMenuItemBuilder = FakeMenuItemBuilder()
        menuManager?.menuItemsReader = fakeMenuItemsReader
        menuManager?.menuItemBuilder = fakeMenuItemBuilder
        menuManager?.objectConfigurator = ObjectConfigurator()
    }

    func testReturnsNilIfMetadataCouldNotBeRead() {
        fakeMenuItemsReader?.errorToReturn = fakeError()
        menuViewController = menuManager?.menuViewController()
        
        XCTAssertNil(menuViewController,
            "Doesn't create menu view controller if metadata couldn't be read")
    }
    
    func testMetadataIsPassedToMenuItemBuilder() {
        menuViewController = menuManager?.menuViewController()
        var (metadataReturnedByReader, _) = fakeMenuItemsReader!.readMenuItems()
        let metadataReceivedByBuilder = fakeMenuItemBuilder!.metadata
        
        XCTAssertTrue(metadataReceivedByBuilder?.count == metadataReturnedByReader?.count,
            "Number of dictionaries in metadata should match")
    }
    
    func testReturnsNilIfMenuItemsCouldNotBeBuilt() {
        fakeMenuItemBuilder?.errorToReturn = fakeError()
        menuViewController = menuManager?.menuViewController()
        
        XCTAssertNil(menuViewController,
            "Doesn't create menu view controller if menu items couldn't be built")
    }
    
    func testCreatesMenuViewControllerIfMenuItemsAvailable() {
        fakeMenuItemBuilder?.menuItemsToReturn = fakeMenuItems()
        menuViewController = menuManager?.menuViewController()
        
        XCTAssertNotNil(menuViewController,
            "Creates menu view controller if menu items are available")
        
        XCTAssertNotNil(menuViewController?.dataSource,
            "Menu view controller is given a data source")
    }
    
    func fakeError() -> NSError {
        let errorMessage = "Fake error description"
        let userInfo = [NSLocalizedDescriptionKey: errorMessage]
        
        return NSError(domain: "Fake Error domain",
                       code: 0,
                       userInfo: userInfo)
    }
    
    func fakeMenuItems() -> [MenuItem] {
        let menuItem = MenuItem(title: "Fake menu item")
        return [menuItem]
    }
}
