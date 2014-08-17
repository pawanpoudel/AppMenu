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
    func testErrorIsReturnedWhenPlistFileDoesNotExist() {
        
        var plistReader = MenuItemsPlistReader()
        plistReader.plistToReadFrom = "notFound.plist"
        
        var (metadata: [[String : String]]?, error: NSError?) = plistReader.readMenuItems()
        XCTAssertNotNil(error, "An error is returned when the specified plist file doesn't exist")
    }
}

//class MenuItemsPlistReader: MenuItemsReader {
//    
//    /**
//    A string object that contains the name of the plist file
//    to read menu items metadata from.
//    */
//    var plistToReadFrom: String?
//    
//    func readMenuItems() -> [[String : String]]? {
//        let filePath = NSBundle.mainBundle().pathForResource(plistToReadFrom, ofType: "plist")
//        return NSArray(contentsOfFile: filePath) as [[String : String]]
//    }
//    
//    func readMenuItems() -> ([[String : String]]?, NSError?) {
//        return ([], nil)
//    }
//}
//
//describe(@"MDMenuPlistReader", ^{
//    MDMenuPlistReader __block *menuPlistReader = nil;
//    NSString __block *testPlistToReadFrom = nil;
//    
//    beforeEach(^{
//        menuPlistReader = [[MDMenuPlistReader alloc] init];
//        testPlistToReadFrom = @"testMenuItems.plist";
//        menuPlistReader.plistToReadFrom = testPlistToReadFrom;
//        });
//    
//    it(@"conforms to MDMenuReader protocol", ^{
//        [[menuPlistReader should] conformToProtocol:@protocol(MDMenuReader)];
//    });
//    
//    it(@"reads given file's full path in app bundle", ^{
//    id mockNSBundle = [NSBundle nullMock];
//    [NSBundle stub:@selector(mainBundle)
//    andReturn:mockNSBundle];
//    
//    [[[mockNSBundle should] receive] pathForResource:testPlistToReadFrom
//    ofType:@"plist"];
//    [menuPlistReader readMenuItems];
//    });
//    
//    it(@"creates and returns an array of menu items from given plist", ^{
//    id mockNSBundle = [NSBundle nullMock];
//    [NSBundle stub:@selector(mainBundle)
//    andReturn:mockNSBundle];
//    
//    NSString *testPlistFilePath = @"/path/to/testMenuItems.plist";
//    [mockNSBundle stub:@selector(pathForResource:ofType:)
//    andReturn:testPlistFilePath];
//    
//    NSDictionary *testMenuItem = @{ @"title": @"Test Menu Item" };
//    NSArray *expectedRawMenuItemsArray = @[testMenuItem];
//    
//    [[NSArray should] receive:@selector(arrayWithContentsOfFile:)
//    andReturn:expectedRawMenuItemsArray
//    withArguments:testPlistFilePath];
//    
//    [[[menuPlistReader readMenuItems] should] equal:expectedRawMenuItemsArray];
//    });
//});
