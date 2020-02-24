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

// This is where all the magic happens

struct EcgManager {
        
    func sendEcgsToServer(pathToZip: String) {
        unzipExport(pathToZip: pathToZip)
        
        // Check whether there are new ecgs
        let ecgsAsCsv = getCSVsFromUnzippedExport()
        if ecgsAsCsv.count == 0 {
            // All the ECGs have been previously imported
            return
        }
        
        // Convert ecgs to FHIR Json
        let ecgsInFhirJson = convertCSVsToFHIR(ecgsAsCSV: ecgsAsCsv)
            
        // Convert ecgs in FHIR JSON to observations
        let converter = FhirJsonToObservationConverter()
        let observations = converter.convertFhirJsonsToObservations(ecgsInFhirJson: ecgsInFhirJson)
        //dump(ecgsInFhirJson[0])
        
        // Send ecgs to server
        //let serverconnector = ServerConnector()
        //serverconnector.sendObservationsToServer(observations: observations)
        
        print("Done")
    }
        
    private func convertCSVsToFHIR(ecgsAsCSV: Array<CSVReader>) -> Array<FHIRJSON> {
        let converter = CsvToFhirJsonConverter()
        let ecgsAsFHIR = converter.getFhirJsonsFromCsvs(ecgsAsCsv: ecgsAsCSV)
        return ecgsAsFHIR
    }
    
    private func getCSVsFromUnzippedExport() -> Array<CSVReader> {
        let importer = CsvImporter()
        let arrayWithCSVs = importer.getCSVs()
        return arrayWithCSVs
    }
    
    private func unzipExport(pathToZip: String) {
        let unzipper = Unzipper()
        unzipper.unzipFile(pathToZip: pathToZip)
    }
}
