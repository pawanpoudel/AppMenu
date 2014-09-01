//
//  ContributionsViewController.swift
//  AppMenu
//
//  Created by Pawan Poudel on 8/30/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

import UIKit

class ContributionsViewController: FeatureViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let topVC = self.navigationController.topViewController
        
        let isIt = topVC is ContributionsViewController
        println("isIt: \(isIt)")
        
        let feature = topVC.valueForKey("featureName") as String
        
        println("feature: \(feature)")
        
    }
}
