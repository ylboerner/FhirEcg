//
//  JSONConverter.swift
//  ECG Workflow Share Extension
//
//  Created by Yannick Börner on 21.01.20.
//  Copyright © 2020 Berlin Institute of Health. All rights reserved.
//

import Foundation
//import SwiftCSV
import SMART
import CSV

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
        let template = getJSONTemplate()
        
        
        return returnDummy()
    }
    
    func getJSONTemplate() -> FHIRJSON?{
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
