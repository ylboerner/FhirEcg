//
//  Unzipper.swift
//  ECG Workflow Share Extension
//
//  Created by Yannick Börner on 22.01.20.
//  Copyright © 2020 Berlin Institute of Health. All rights reserved.
//

import Foundation
import ZipArchive

struct Unzipper {
    
    func unzipFile(relativePathToZip: String) {
        // This apps own document folder
        let documentsURL: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let relativePathToDocuments = documentsURL.relativePath
        
        // Unzip the export into this apps document folder. Will evaluate to false or nil if unsuccessful
        let unzip: Void? = try? SSZipArchive.unzipFile(atPath: relativePathToZip, toDestination: relativePathToDocuments, overwrite: true, password: nil)
    }
}
