//
//  MenuItemsPlistReaderTests.swift
//  AppMenu
//
//  Created by Pawan Poudel on 8/17/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

import UIKit
import XCTest

class MenuItemsPlistReaderTests: XCTestCase {
    var plistReader: MenuItemsPlistReader?
    var metadata: [[String : String]]?
    var error: NSError?
    
    override func setUp() {
        super.setUp()
        plistReader = MenuItemsPlistReader()
        plistReader?.plistToReadFrom = "notFound"
        (metadata, error) = plistReader!.readMenuItems()
    }
    
    func testCorrectErrorDomainIsReturnedWhenPlistDoesNotExist() {
        let errorDomain = error?.domain
        XCTAssertEqual(errorDomain!, MenuItemsPlistReaderErrorDomain,
            "Correct error domain is returned when plist not found")
    }
    
    func testFileNotFoundErrorCodeIsReturnedWhenPlistDoesNotExist() {
        let errorCode = error?.code
        XCTAssertEqual(errorCode!, MenuItemsPlistReaderErrorCode.FileNotFound.toRaw(),
            "Correct error code is returned  when plist not found")
    }
    
    func testCorrectErrorDescriptionIsReturnedWhenPlistDoesNotExist() {
        let userInfo = error?.userInfo
        let description: String = userInfo![NSLocalizedDescriptionKey]! as String
        XCTAssertEqual(description, "notFound.plist file doesn't exist in app bundle",
            "Correct error description is returned when plist not found")
    }
    
    func testPlistIsDeserializedCorrectly() {
        plistReader!.plistToReadFrom = "menuItems"
        (metadata, error) = plistReader!.readMenuItems()
        
        XCTAssertTrue(metadata?.count == 3, "There should only be three dictionaries in plist")
        
        let firstRow = metadata?[0]
        XCTAssertEqual(firstRow!["title"]!, "Contributions",
            "First row's title should be what's in plist")
        XCTAssertEqual(firstRow!["subTitle"]!, "Repos contributed to",
            "First row's subtitle should be what's in plist")
        XCTAssertEqual(firstRow!["iconName"]!, "iconContributions",
            "First row's icon name should be what's in plist")
        XCTAssertEqual(firstRow!["tapHandlerName"]!, "ContributionsViewController",
            "First row's tap handler should be what's in plist")
        
        let secondRow = metadata?[1]
        XCTAssertEqual(secondRow!["title"]!, "Repositories",
            "Second row's title should be what's in plist")
        XCTAssertEqual(secondRow!["subTitle"]!, "Repos collaborating",
            "Second row's subtitle should be what's in plist")
        XCTAssertEqual(secondRow!["iconName"]!, "iconRepositories",
            "Second row's icon name should be what's in plist")
        XCTAssertEqual(secondRow!["tapHandlerName"]!, "RepositoriesViewController",
            "Second row's tap handler should be what's in plist")
        
        let thirdRow = metadata?[2]
        XCTAssertEqual(thirdRow!["title"]!, "Public Activity",
            "Third row's title should be what's in plist")
        XCTAssertEqual(thirdRow!["subTitle"]!, "Activity viewable by anyone",
            "Third row's subtitle should be what's in plist")
        XCTAssertEqual(thirdRow!["iconName"]!, "iconPublicActivity",
            "Third row's icon name should be what's in plist")
        XCTAssertEqual(thirdRow!["tapHandlerName"]!, "PublicActivityViewController",
            "Third row's tap handler should be what's in plist")
    }
}
