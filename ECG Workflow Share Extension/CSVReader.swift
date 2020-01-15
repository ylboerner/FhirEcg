//
//  CSVReader.swift
//  ECG Workflow Share Extension
//
//  Created by Yannick Börner on 15.01.20.
//  Copyright © 2020 Berlin Institute of Health. All rights reserved.
//

import Foundation

struct CSVReader {
    
    func getEcgCsvUrl() {
        
    }
    
    func printContentsOfDocumentsURL() {
        let documentsURL: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
            print(fileURLs.count)
            print(fileURLs[0].relativePath)
            // process files
        } catch {
            print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
        }
    }
}
