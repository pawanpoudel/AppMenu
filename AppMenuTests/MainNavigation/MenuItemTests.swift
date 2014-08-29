//
//  MenuItemTests.swift
//  AppMenu
//
//  Created by Pawan Poudel on 8/23/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

import UIKit
import XCTest

class MenuItemTests: XCTestCase {
    var menuItem: MenuItem?
    
    override func setUp() {
        super.setUp()
        menuItem = MenuItem(title: "Contributions")
    }
    
    func testThatMenuItemHasATitle() {
        XCTAssertEqual(menuItem!.title, "Contributions",
            "A title should always be present")
    }
    
    func testThatMenuItemCanBeAssignedASubTitle() {
        menuItem!.subTitle = "Repos contributed to"
        XCTAssertEqual(menuItem!.subTitle!, "Repos contributed to",
            "Subtitle should be what we assigned")
    }
    
    func testThatMenuItemCanBeAssignedAnIconName() {
        menuItem!.iconName = "contributionsIcon"
        XCTAssertEqual(menuItem!.iconName!, "contributionsIcon",
            "Icon name should be what we assigned")
    }
    
    func testThatMenuItemCanBeAssignedAFeatureName() {
        menuItem!.featureName = "someFeature"
        XCTAssertEqual(menuItem!.featureName!, "someFeature",
            "Feature name should be what we assigned")
    }
}


//class MenuItemTests: XCTestCase {
//    var menuItem: MenuItem?
//    
//    override func setUp() {
//        super.setUp()
//        menuItem = MenuItem(title: "Contributions",
//                            subTitle: "Repos contributed to",
//                            iconName: "contributionsIcon")
//    }
//    
//    func testThatMenuItemHasATitle() {
//        XCTAssertEqual(menuItem!.title, "Contributions", "A title should always be present")
//    }
//    
//    func testThatMenuItemCanBeAssignedASubTitle() {
//        XCTAssertEqual(menuItem!.subTitle!, "Repos contributed to", "Subtitle should be what we assigned")
//    }
//    
//    func testThatMenuItemCanBeAssignedAnIcon() {
//        XCTAssertEqual(menuItem!.iconName!, "contributionsIcon", "Icon name should be what we assigned")
//    }
//}
