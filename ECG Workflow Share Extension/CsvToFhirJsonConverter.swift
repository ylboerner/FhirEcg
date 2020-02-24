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
            // Skip, if there are missing values in the row
            if (row.count < 2) {
                continue
            }
            
            // Extract key and value
            let key = row[0]
            let value = row[1]
            
            // Extract information and store it in the JSON object
            switch key {
                
            case "Name":
                template!["subject"]["display"].string = value
                template!["subject"]["reference"].string = value
                template!["performer"][0]["display"].string = value
                template!["performer"][0]["reference"].string = value

            case "Device":
                template!["device"]["display"].string = value
                
            case "Recorded Date":
                template!["effectiveDateTime"].string = value
            
            case "Sample Rate":
                template!["component"][0]["valueSampledData"]["period"].double = getPeriodFromRow(row: row)
            
            case "Classification":
                template!["component"][1]["valueString"].string = value
            
            // TODO Catch empty case
            case "Symptoms":
                if value.isEmpty {
                    // No symptoms found, delete symptoms component from observation
                    template!["component"].arrayObject?.remove(at: 2)
                } else {
                    template!["component"][2]["valueString"].string = getSymptomsFromRow(row: row)
                }
                
            default:
                // Check if both key and value are integers. If so, concatenate them with the string holding all the values
                if (Int(key) != nil && Int(value) != nil) {
                    let value = Float(key + "." + value)
                    measurements = measurements + String(value!) + " "
                }
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
    
    private func getPeriodFromRow(row: [String]) -> Double {
        let valueOne = row[1]
        let valueTwo = row[2]
        let hz = Double(valueOne.westernArabicNumeralsOnly + "." + valueTwo.westernArabicNumeralsOnly)
        
        // Formula converting hz to period in ms
        let ms = 1/hz! * 1000
        return ms
    }
    
    private func getSymptomsFromRow(row: [String]) -> String {
        var symptoms = "Symptoms: "
        for i in 1...row.count-1 {
            symptoms = symptoms + row[i] + " "
        }
        return symptoms
    }
    
    private func getFhirJsonEcgObservationTemplate() -> JSON? {
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

extension String {
    var westernArabicNumeralsOnly: String {
        let pattern = UnicodeScalar("0")..."9"
        return String(unicodeScalars
            .compactMap { pattern ~= $0 ? Character($0) : nil })
    }
}
