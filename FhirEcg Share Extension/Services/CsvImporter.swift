//
//  CSVReader.swift
//  ECG Workflow Share Extension
//
//  Created by Yannick Börner on 15.01.20.
//  Copyright © 2020 Berlin Institute of Health. All rights reserved.
//

import Foundation
import CSV

struct CsvImporter {
    
    private let defaults = UserDefaults.standard

    func getCSVs() -> Array<DataCsvImport> {
        // Initialize array before it is used in a do catch block
        var allCSVs = [DataCsvImport]()
        let csvURLs = getCsvURLs()
        
        for csvURL in csvURLs {
            // Check whether this ECG has been imported before
            if PersistenceController.ecgHasBeenSentPreviously(url: csvURL) == false {
                let stream = InputStream(fileAtPath: csvURL.relativePath)!
                let csv = try! CSVReader(stream: stream)
                let csvI = DataCsvImport(urlToCSV: csvURL, csvReader: csv)
                allCSVs.append(csvI)
            }
        }
        return allCSVs
    }
    
    // Retrieve an array of every CSVs URL
    private func getCsvURLs() -> Array<URL> {
        var csvURLs = [URL]()
        do {
            csvURLs = try FileManager.default.contentsOfDirectory(at: getCsvDirectory(), includingPropertiesForKeys: nil)
        } catch {
            print(error)
        }
        return csvURLs
    }
    
    private func getCsvDirectory() -> URL {
        let csvURL = URL(string: getDocumentsDirectory().relativePath + "/apple_health_export/electrocardiograms/")
        return csvURL!
    }
    
    private func getDocumentsDirectory() -> URL {
        let documentsURL: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsURL
    }
}
