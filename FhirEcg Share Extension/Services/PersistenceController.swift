//
//  PersistanceController.swift
//  ECG Workflow Share Extension
//
//  Created by Yannick Börner on 18.04.20.
//  Copyright © 2020 Berlin Institute of Health. All rights reserved.
//

import Foundation


class PersistenceController {
    
    private static let defaults = UserDefaults(suiteName: "group.com.bih.ecgworkflow")!
    
    public static func markEcgAsSent(url: URL) {
        defaults.set(true, forKey: url.relativePath)
    }
    
    public static func ecgHasBeenSentPreviously(url: URL) -> Bool {
        let storedURL = defaults.bool(forKey: url.relativePath)
        if storedURL {
            return true
        } else {
            return false
        }
    }
    
    public static func getValueFromUserDefaults(key: String) -> String? {
        let value = defaults.string(forKey: key)
        return value
    }
}
