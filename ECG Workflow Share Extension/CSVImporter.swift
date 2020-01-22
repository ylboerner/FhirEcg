//
//  CSVReader.swift
//  ECG Workflow Share Extension
//
//  Created by Yannick Börner on 15.01.20.
//  Copyright © 2020 Berlin Institute of Health. All rights reserved.
//

import Foundation
import CSV
//import CSVSwift

struct CSVImporter {

    func getCSVs() -> Array<CSVReader> {
        // Initialize array before it is used in a do catch block
        var allCSVs = [CSVReader]()
        let csvURLs = getCsvURLs()
        
        for csvURL in csvURLs {
            let stream = InputStream(fileAtPath: csvURL.relativePath)!
            let csv = try! CSVReader(stream: stream)
            allCSVs.append(csv)

            /*
            while let row = csv.next() {
                print("\(row)")
            }
            */
        }
        print("Heloo")
        
        /*
        for csvURL in csvURLs {
            do {
                
                //print(csvURL)
                // Parse CSV and append it to the array
                let csv: CSV = try CSV(url: csvURL)
                allCSVs.append(csv)
            } catch {
                print(error)
            }
        }
*/
        return allCSVs
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
