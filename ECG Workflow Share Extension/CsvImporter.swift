//
//  CSVReader.swift
//  ECG Workflow Share Extension
//
//  Created by Yannick Börner on 15.01.20.
//  Copyright © 2020 Berlin Institute of Health. All rights reserved.
//

import Foundation
import CSV

struct CSVImporter {
    
    let defaults = UserDefaults.standard

    func getCSVs() -> Array<CSVReader> {
        // Initialize array before it is used in a do catch block
        var allCSVs = [CSVReader]()
        let csvURLs = getCsvURLs()
        
        for csvURL in csvURLs {
            // Check whether this ECG has been imported before
            if ecgHasBeenPreviouslyImported(url: csvURL) == false {
                let stream = InputStream(fileAtPath: csvURL.relativePath)!
                let csv = try! CSVReader(stream: stream)
                allCSVs.append(csv)
                markEcgAsImported(url: csvURL)
            }
        }
        return allCSVs
    }
    
    func markEcgAsImported(url: URL) {
        defaults.set(true, forKey: url.relativePath)
    }
    
    func ecgHasBeenPreviouslyImported(url: URL) -> Bool {
        let storedURL = defaults.bool(forKey: url.relativePath)
        if storedURL {
            return true
        } else {
            return false
        }
    }
    
    // Retrieve an array of every CSVs URL
    func getCsvURLs() -> Array<URL> {
        var csvURLs = [URL]()
        do {
            csvURLs = try FileManager.default.contentsOfDirectory(at: getCsvDirectory(), includingPropertiesForKeys: nil)
        } catch {
            print(error)
        }
        return csvURLs
    }
    
    func getCsvDirectory() -> URL {
        let csvURL = URL(string: getDocumentsDirectory().relativePath + "/apple_health_export/electrocardiograms/")
        return csvURL!
    }
    
    func getDocumentsDirectory() -> URL {
        let documentsURL: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsURL
    }
}
