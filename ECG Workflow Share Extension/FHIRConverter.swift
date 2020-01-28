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

struct FHIRConverter {
    
    func getFHIRInstancesFromCSV(allECGs: Array<CSVReader>) -> [FHIRJSON] {
        var fhirInstances = [FHIRJSON]()
        for csv in allECGs {
            let csvAsJSON = convertCSVtoJSON(csv: csv)
            fhirInstances.append(csvAsJSON!)
        }
        return fhirInstances
    }
    
    func convertCSVtoJSON(csv: CSVReader) -> FHIRJSON? {
        var template = getJSONTemplate()
        var columnOne = ""
        var columnTwo = ""
        
        while let row = csv.next() {
            // Skip, if the row has a missing entry
            if (row.count < 2) {
                continue
            }
            
            // Extract both values
            let valueOne = row[0]
            let valueTwo = row[1]
            
            // Check if both are integers. If so, concatenate them with the string holding all the values and continue the loop
            if (Int(valueOne) != nil && Int(valueTwo) != nil) {
                columnOne = columnOne + valueOne + " "
                columnTwo = columnTwo + valueTwo + " "
                continue
            }
            
            // Extract information and store it in the JSON object
            switch valueOne {
            case "Name":
                template!["subject"]["display"].string = valueTwo
                template!["performer"]["display"].string = valueTwo
                /*
                var nameDict = template!["subject"] as! Dictionary<String,Any>
                nameDict["display"] = row[1]
                template!["subject"] = nameDict
                */
            case "Device":
                template!["device"]["display"].string = valueTwo
            case "Recorded Date":
                template!["effectiveDateTime"].string = valueTwo
            case "Symptoms":
                template!["note"]["symptoms"].string = valueTwo
            case "Classification":
                template!["interpretation"]["classification"].string = valueTwo
            default:
                continue
            }
        }
        
        // Add both strings holding all the values to the JSON object
        template!["component"][0]["valueSampledData"]["origin"]["value"].string = columnOne
        template!["component"][1]["valueSampledData"]["origin"]["value"].string = columnTwo

        dump(template)
        print("Hold")
        return returnDummy() as! FHIRJSON
    }
    
    func getJSONTemplate() -> JSON? {
        let url = Bundle.main.url(forResource: "JSONObservationECGTemplate", withExtension: "json")!
        let data = NSData(contentsOf: url)! as Data
        
        do {
            let json = try JSON(data: data)
            return json
        } catch {
            print(error)
            return nil
        }
    }
    
    func returnDummy() -> FHIRJSON? {
        let url = Bundle.main.url(forResource: "JSONObservationECGTemplate", withExtension: "json")!
        let data = NSData(contentsOf: url)! as Data
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! FHIRJSON
            return json
        } catch {
            print(error)
            return nil
        }
    }
}
