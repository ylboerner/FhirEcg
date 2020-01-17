//
//  CSVReader.swift
//  ECG Workflow Share Extension
//
//  Created by Yannick Börner on 15.01.20.
//  Copyright © 2020 Berlin Institute of Health. All rights reserved.
//

import Foundation
import SwiftCSV

struct CSVReader {

    func getCSVs() -> Array<CSV> {
        // Initialize array before it is used in a do catch block
        var allCSVs = [CSV]()
        let csvURLs = getCsvURLs()
        
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
    
    /*
    func printContentsOfDocumentsURL() {
        let documentsURL: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
            print(fileURLs.count)
            print(fileURLs[0].relativePath)
        } catch {
            print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
        }
    }
    */
    
    /*
    func getCsvURLs() -> Array<String> {
        let csvDirectory = getCsvDirectory()
        let enumerator = FileManager.default.enumerator(atPath: csvDirectory.absoluteString)
        let filePaths = enumerator?.allObjects as! [String]
        let csvURLs = filePaths.filter{$0.contains(".csv")}
        
        return csvURLs
    }
    */
    
   /*
   func getAllCsvPaths() -> Array<URL> {
       let csvDirectory = getCSVPath()
       var csvURLs: [URL]
       
       do {
           csvURLs = try FileManager.default.contentsOfDirectory(at: csvDirectory, includingPropertiesForKeys: nil)
           print(csvURLs)
       } catch {
           print("No CSVs could be found")
       }
       return csvURLs
   }
     */
}
