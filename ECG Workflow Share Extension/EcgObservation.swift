//
//  EcgObservation.swift
//  ServerConnectionTest
//
//  Created by Yannick Börner on 12.03.20.
//  Copyright © 2020 Berlin Institute of Health. All rights reserved.
//

import Foundation
import SMART
import CSV
import SwiftyJSON

class EcgObservation {
    
    var ecgData: CsvParser
    var fhirObservation: JSON?
    var fhirObservationInFhirJson: FHIRJSON?
    var smartObservation: Observation?
    let templates = ObservationJsonTemplates()
    let resources = Resources()
    
    init(data: CsvParser) {
        self.ecgData = data
        buildFhirObservation()
        convertJsonToFhirJson()
        convertFhirObservationToSmartObservation()
    }
    
    private func buildFhirObservation() {
        // Load observation template
        fhirObservation = templates.observationTemplate

        // Name
        fhirObservation!["subject"]["display"].string = ecgData.name!
        fhirObservation!["subject"]["reference"].string = ecgData.name!
        fhirObservation!["performer"][0]["display"].string = ecgData.name!
        fhirObservation!["performer"][0]["reference"].string = ecgData.name!
        
        // Device
        fhirObservation!["device"]["display"].string = ecgData.device!
        
        // Recorded Date
        fhirObservation!["effectiveDateTime"].string = ecgData.date!
        
        // Period
        fhirObservation!["component"][0]["valueSampledData"]["period"].double = ecgData.period
        
        // Measurements
        fhirObservation!["component"][0]["valueSampledData"]["data"].string = getMeasurementsAsString()
        
        // Classification
        addClassificationComponent()
        
        // Symptoms
        addSymptomComponents()

    }
    
    private func getMeasurementsAsString() -> String {
        var measurementsAsString = ""
        for measurement in ecgData.measurements {
            measurementsAsString = measurementsAsString + String(measurement) + " "
        }
        return measurementsAsString
    }
    
    private func addClassificationComponent() {
        if let classification = resources.classifications.first(where: { $0.nameEng == ecgData.classification || $0.nameGer == ecgData.classification }) {
            let component = createClassificationComponent(system: classification.system, code: classification.code, display: classification.display)
            addComponent(component: component)
        }
    }
    
    private func addSymptomComponents() {
        // Case no symptoms
        if ecgData.symptoms[0].isEmpty {
            addComponent(component: templates.symptomsAskedButDeclinedComponentTemplate)
        } else {
        // Case symptoms or "None"
            for symptom in ecgData.symptoms {
                if let symptomData = resources.symptoms.first(where: { $0.nameEng == symptom || $0.nameGer == symptom }) {
                    let component = createSymptomComponent(system: symptomData.system, code: symptomData.code, display: symptomData.display)
                    addComponent(component: component)
                }
            }
        }
    }
    
    private func createClassificationComponent(system: String, code: String, display: String) -> JSON {
        var classification = templates.classificationComponentTemplate
        classification["valueCodeableConcept"]["coding"][0]["system"].string = system
        classification["valueCodeableConcept"]["coding"][0]["code"].string = code
        classification["valueCodeableConcept"]["coding"][0]["display"].string = display
        classification["valueCodeableConcept"]["text"].string = display
        return classification
    }
    
    func createSymptomComponent(system: String, code: String, display: String) -> JSON {
        var symptom = templates.symptomComponentTemplate
        symptom["valueCodeableConcept"]["coding"][0]["system"].string = system
        symptom["valueCodeableConcept"]["coding"][0]["code"].string = code
        symptom["valueCodeableConcept"]["coding"][0]["display"].string = display
        symptom["valueCodeableConcept"]["text"].string = display
        return symptom
    }
    
    private func addComponent(component: JSON) {
        fhirObservation?["component"].appendIfArray(json: component)
    }
    
    private func convertJsonToFhirJson() {
        do {
             fhirObservationInFhirJson = try JSONSerialization.jsonObject(with: fhirObservation!.rawData(), options: []) as! FHIRJSON
        } catch {
             print(error)
        }
    }
    
    private func convertFhirObservationToSmartObservation() {
        do {
            smartObservation = try Observation(json: fhirObservationInFhirJson!)
        } catch {
            print(error)
        }
    }
}

extension JSON{
    mutating func appendIfArray(json:JSON){
        if var arr = self.array{
            arr.append(json)
            self = JSON(arr);
        }
    }
    
    /*
    mutating func appendIfDictionary(key:String,json:JSON){
        if var dict = self.dictionary{
            dict[key] = json;
            self = JSON(dict);
        }
    }
    */
}
