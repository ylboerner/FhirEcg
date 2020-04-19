//
//  PersistanceController.swift
//  ECG Workflow Share Extension
//
//  Created by Yannick Börner on 18.04.20.
//  Copyright © 2020 Berlin Institute of Health. All rights reserved.
//

import Foundation


class PersistenceController {
    
    private static let defaults = UserDefaults.standard
    
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
    
    public static func getServerAddress() -> String {
        return "https://vonk-server.azurewebsites.net/"
    }
    
    public static func getPatientReference() -> String {
        return "e5100d62-be0a-4515-8aa1-5280aad185f5"
    }
}
