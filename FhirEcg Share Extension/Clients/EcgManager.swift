//
//  EcgManager.swift
//  ECG Workflow Share Extension
//
//  Created by Yannick Börner on 07.02.20.
//  Copyright © 2020 Berlin Institute of Health. All rights reserved.
//

import Foundation
import CSV
import SMART
import SwiftyJSON

struct EcgManager {
        
    func importEcgsAndSendThemToServer(pathToArchive: String) {
        let archiveExtractor = ArchiveExtractor()
        archiveExtractor.extractArchive(pathToArchive: pathToArchive)
        
        // Check whether there are new ecgs
        let csvs = getCSVsFromExtractedArchive()
        if csvs.count == 0 {
            print("No ecgs")
            // All the ECGs have been previously imported
            return
        }
        
        // Parse ecgs
        let ecgObservations = getEcgObservations(csvImports: csvs)
        
        // Pan Tompkins Implementation
        // Currently commented out until a new digital filter has been created and implemented
        //let adapter = PanTompkinsAdapter()
        //adapter.pan()
        
        // Send ecgs to server
        let serverconnector = ServerConnector()
        serverconnector.sendObservationsToServer(observations: ecgObservations)
        
        print("Done")
    }
    
    private func getEcgObservations(csvImports: Array<DataCsvImport>) -> Array<EcgObservation> {
        var ecgObservations = Array<EcgObservation>()
        for csvImport in csvImports {
            let ecgObservation = EcgObservation(csvImport: csvImport)
            ecgObservations.append(ecgObservation)
            //writeToFile(json: ecgObservation.fhirObservation, date: ecgObservation.ecgData.date!)
            //print(ecgObservation.fhirObservation)
        }
        return ecgObservations
    }
    
    private func getCSVsFromExtractedArchive() -> Array<DataCsvImport> {
        let importer = CsvImporter()
        let arrayWithCSVs = importer.getCSVs()
        return arrayWithCSVs
    }
    
    private func writeToFile(json: JSON?, date: String) {
        if let encodedData = try? JSONEncoder().encode(json) {
            var downloadsDirectory = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!
            downloadsDirectory = downloadsDirectory.appendingPathComponent(date)
            do {
                try encodedData.write(to: downloadsDirectory)
            }
            catch {
                print("Failed to write JSON data: \(error.localizedDescription)")
            }
        }
    }
}
