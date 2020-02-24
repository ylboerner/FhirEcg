//
//  FhirJsonToObservationConverter.swift
//  ECG Workflow Share Extension
//
//  Created by Yannick Börner on 07.02.20.
//  Copyright © 2020 Berlin Institute of Health. All rights reserved.
//

import Foundation
import SMART

struct FhirJsonToObservationConverter {
    
    func convertFhirJsonsToObservations(ecgsInFhirJson: Array<FHIRJSON>) -> Array<Observation> {
        var observations = [Observation]()
        for ecgInFHIRJSON in ecgsInFhirJson {
            do {
                let observation = try Observation(json: ecgInFHIRJSON)
                observations.append(observation)
            } catch {
                print(error)
            }
        }
        return observations
    }
}
