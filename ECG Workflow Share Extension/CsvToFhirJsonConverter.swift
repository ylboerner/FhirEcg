//
//  JSONConverter.swift
//  ECG Workflow Share Extension
//
//  Created by Yannick Börner on 21.01.20.
//  Copyright © 2020 Berlin Institute of Health. All rights reserved.
//

import Foundation
import SMART
import CSV
import SwiftyJSON

struct CsvToFhirJsonConverter {
    
    func getFhirJsonsFromCsvs(ecgsAsCsv: Array<CSVReader>) -> [FHIRJSON] {
        var ecgsAsFhirJson = [FHIRJSON]()
        for csv in ecgsAsCsv {
            let csvAsJson = convertCsvToFhirJson(csv: csv)
            ecgsAsFhirJson.append(csvAsJson!)
        }
        return ecgsAsFhirJson
    }
    
    func convertCsvToFhirJson(csv: CSVReader) -> FHIRJSON? {
        var template = getFhirJsonEcgObservationTemplate()
        var measurements = ""
        
        while let row = csv.next() {
            // Skip, if the row's value is missing
            if (row.count < 2) {
                continue
            }
            
            // Extract both values
            let valueOne = row[0]
            let valueTwo = row[1]
            
            // Check if both are integers. If so, concatenate them with the string holding all the values and continue the loop
            if (Int(valueOne) != nil && Int(valueTwo) != nil) {
                let value = Float(valueOne + "." + valueTwo)
                measurements = measurements + String(value!) + " "
                continue
            }
            
            // Extract information and store it in the JSON object
            switch valueOne {
                
            case "Name":
                template!["subject"]["display"].string = valueTwo
                template!["subject"]["reference"].string = valueTwo
                template!["performer"][0]["display"].string = valueTwo
                template!["performer"][0]["reference"].string = valueTwo

            case "Device":
                template!["device"]["display"].string = valueTwo
                
            case "Recorded Date":
                template!["effectiveDateTime"].string = valueTwo
            
            case "Sample Rate":
                // TODO
                // Read in proper Hz
                // Conversion from Hz to ms
                template!["component"][0]["valueSampledData"]["period"].double = 14.705882352941
            
            case "Classification":
                template!["component"][1]["valueString"].string = valueTwo
            
            // TODO Catch empty case
            case "Symptoms":
                var symptoms = "Symptoms: "
                for i in 1...row.count-1 {
                    symptoms = symptoms + row[i] + " "
                }
                template!["component"][2]["valueString"].string = symptoms
                
            default:
                continue
            }
        }
        
        // Add both strings holding all the ECG's data to the JSON object
        template!["component"][0]["valueSampledData"]["data"].string = measurements
        
        do {
            let convertedData = try JSONSerialization.jsonObject(with: template!.rawData(), options: []) as! FHIRJSON
            return convertedData
       } catch {
            print(error)
            return nil
       }
    }
    
    func getFhirJsonEcgObservationTemplate() -> JSON? {
        let url = Bundle.main.url(forResource: "AppleWatchFhirJsonEcgObservationTemplate", withExtension: "json")!
        let data = NSData(contentsOf: url)! as Data
        
        do {
            let json = try JSON(data: data)
            return json
        } catch {
            print(error)
            return nil
        }
    }
}
