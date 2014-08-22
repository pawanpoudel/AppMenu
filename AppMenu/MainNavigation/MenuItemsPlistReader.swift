//
//  MenuItemsPlistReader.swift
//  AppMenu
//
//  Created by Pawan Poudel on 8/17/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

import Foundation

let MenuItemsPlistReaderErrorDomain = "MenuItemsPlistReaderErrorDomain"

enum MenuItemsPlistReaderErrorCode : Int {
    case FileNotFound
    case InvalidData
}

class MenuItemsPlistReader: MenuItemsReader {
    var plistToReadFrom: String? = nil
    
    func readMenuItems() -> ([[String : String]]?, NSError?) {
        var error: NSError? = nil
        var fileContents: [[String : String]]? = nil
        
        let bundle = NSBundle(forClass: object_getClass(self))
        
        if let filePath = bundle.pathForResource(plistToReadFrom, ofType: "plist") {
            fileContents = NSArray(contentsOfFile: filePath) as? [[String : String]]
            if fileContents == nil {
                error = invalidDataError()
            }
        }
        else {
            error = fileNotFoundError()
        }
        
        return (fileContents, error)
    }
    
    func fileNotFoundError() -> NSError {
        let errorMessage = "\(plistToReadFrom!).plist file doesn't exist in app bundle"
        let userInfo = [NSLocalizedDescriptionKey: errorMessage]
        
        return NSError(domain: MenuItemsPlistReaderErrorDomain,
                       code: MenuItemsPlistReaderErrorCode.FileNotFound.toRaw(),
                       userInfo: userInfo)
    }
    
    func invalidDataError() -> NSError {
        let errorMessage = "\(plistToReadFrom!).plist file contains invalid data"
        let userInfo = [NSLocalizedDescriptionKey: errorMessage]
        
        return NSError(domain: MenuItemsPlistReaderErrorDomain,
            code: MenuItemsPlistReaderErrorCode.InvalidData.toRaw(),
            userInfo: userInfo)
    }
}
