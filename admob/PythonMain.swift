//
//  PythonMain.swift
//

import Foundation
import GoogleMobileAds

class PythonMain {
    
    static let shared = PythonMain()
    
    let ads_tester = AdsTester()
    
    private init() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
}

