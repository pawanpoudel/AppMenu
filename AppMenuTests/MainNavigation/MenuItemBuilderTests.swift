//
//  MenuItemBuilderTests.swift
//  AppMenu
//
//  Created by Pawan Poudel on 8/24/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

import UIKit
import XCTest

class MenuItemBuilderTests: XCTestCase {
    var menuItemBuilder: MenuItemBuilder?
    var fakeMenuItemsReader: FakeMenuItemsReader?
    var menuItems: [MenuItem]?
    var error: NSError?
    
    override func setUp() {
        fakeMenuItemsReader = FakeMenuItemsReader()
        fakeMenuItemsReader!.missingTitle = true
        let (metadata, _) = fakeMenuItemsReader!.readMenuItems()
        
        menuItemBuilder = MenuItemBuilder()
        (menuItems, error) = menuItemBuilder!.buildMenuItemsFromMetadata(metadata!)
    }
    
    func testCorrectErrorDomainIsReturnedWhenTitleIsMissing() {
        let errorDomain = error?.domain
        XCTAssertEqual(errorDomain!, MenuItemBuilderErrorDomain,
            "Correct error domain is returned")
    }
    
    func testMissingTitleErrorCodeIsReturnedWhenTitleIsMissing() {
        let errorCode = error?.code
        XCTAssertEqual(errorCode!, MenuItemBuilderErrorCode.MissingTitle.toRaw(),
            "Correct error code is returned")
    }
    
    func testCorrectErrorDescriptionIsReturnedWhenTitleIsMissing() {
        let userInfo = error?.userInfo
        let description: String = userInfo![NSLocalizedDescriptionKey]! as String
        XCTAssertEqual(description, "All menu items must have a title",
            "Correct error description is returned")
    }
    
    func testEmptyArrayIsReturnedWhenErrorIsPresent() {
        XCTAssertTrue(menuItems?.count == 0,
            "No menu item instances are returned when error is present")
    }
    
    func testOneMenuItemInstanceIsReturnedForEachDictionary() {
        fakeMenuItemsReader!.missingTitle = false
        let (metadata, _) = fakeMenuItemsReader!.readMenuItems()
        (menuItems, _) = menuItemBuilder!.buildMenuItemsFromMetadata(metadata!)
        
        XCTAssertTrue(menuItems?.count == 2,
            "Number of menu items should be equal to number of dictionaries")
    }
    
    func testMenuItemPropertiesContainValuesPresentInDictionary() {
        fakeMenuItemsReader!.missingTitle = false
        let (metadata, _) = fakeMenuItemsReader!.readMenuItems()
        (menuItems, _) = menuItemBuilder!.buildMenuItemsFromMetadata(metadata!)
        
        let rawDictionary1 = metadata![0]
        let menuItem1 = menuItems![0]
        XCTAssertEqual(menuItem1.title, rawDictionary1["title"]!,
            "First menu item's title should be what's in the first dictionary")
        XCTAssertEqual(menuItem1.subTitle!, rawDictionary1["subTitle"]!,
            "First menu item's subTitle should be what's in the first dictionary")
        XCTAssertEqual(menuItem1.iconName!, rawDictionary1["iconName"]!,
            "First menu item's icon name should be what's in the first dictionary")
        
        let rawDictionary2 = metadata![1]
        let menuItem2 = menuItems![1]
        XCTAssertEqual(menuItem2.title, rawDictionary2["title"]!,
            "Second menu item's title should be what's in the second dictionary")
        XCTAssertEqual(menuItem2.subTitle!, rawDictionary2["subTitle"]!,
            "Second menu item's subTitle should be what's in the second dictionary")
        XCTAssertEqual(menuItem2.iconName!, rawDictionary2["iconName"]!,
            "Second menu item's icon name should be what's in the second dictionary")
    }
}
