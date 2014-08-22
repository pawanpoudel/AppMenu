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
            "Correct error domain is returned")
    }
    
    func testFileNotFoundErrorCodeIsReturnedWhenPlistDoesNotExist() {
        let errorCode = error?.code
        XCTAssertEqual(errorCode!, MenuItemsPlistReaderErrorCode.FileNotFound.toRaw(),
            "Correct error code is returned")
    }
    
    func testCorrectErrorDescriptionIsReturnedWhenPlistDoesNotExist() {
        let userInfo = error?.userInfo
        let description: String = userInfo![NSLocalizedDescriptionKey]! as String
        XCTAssertEqual(description, "notFound.plist file doesn't exist in app bundle",
            "Correct error description is returned")
    }
    
    func testPlistIsDeserializedCorrectly() {
        plistReader!.plistToReadFrom = "testMenuItems"
        (metadata, error) = plistReader!.readMenuItems()
        
        XCTAssertTrue(metadata?.count == 2, "There should only be two dictionaries in plist")
        
        let firstRow = metadata?[0]
        XCTAssertEqual(firstRow!["title"]!, "Test row 1",
            "First row's title should be what's in plist")
        XCTAssertEqual(firstRow!["subTitle"]!, "Test row 1 subtitle",
            "First row's subtitle should be what's in plist")
        XCTAssertEqual(firstRow!["iconName"]!, "iconName1",
            "First row's icon name should be what's in plist")
        
        let secondRow = metadata?[1]
        XCTAssertEqual(secondRow!["title"]!, "Test row 2",
            "Second row's title should be what's in plist")
        XCTAssertEqual(secondRow!["subTitle"]!, "Test row 2 subtitle",
            "Second row's subtitle should be what's in plist")
        XCTAssertEqual(secondRow!["iconName"]!, "iconName2",
            "Second row's icon name should be what's in plist")
    }
}
