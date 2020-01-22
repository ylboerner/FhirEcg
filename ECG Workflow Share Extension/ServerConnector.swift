//
//  ServerConnector.swift
//  ECG Workflow Share Extension
//
//  Created by Yannick Börner on 21.01.20.
//  Copyright © 2020 Berlin Institute of Health. All rights reserved.
//
/*
import Foundation
import SMART

class ServerConnector {
    
    var smartConnection: Client
    
    init() {
        smartConnection = Client(
            baseURL: URL(string: "https://fhir-api-dstu2.smarthealthit.org")!,
            settings: [
                //"client_id": "my_mobile_app",       // if you have one
                "redirect": "smartapp://callback",    // must be registered
            ]
        )
    }
    
    func sendDatatoServer() {
        // authorize, then search for prescriptions
        smartConnection.authorize() { patient, error in
            if nil != error || nil == patient {
                // report error
            }
            else {
                /*
                MedicationOrder.search(["patient": patient.id])
                .perform(smartConnection.server) { bundle, error in
                    if nil != error {
                        // report error
                    }
                    else {
                        let meds = bundle?.entry?
                            .filter() { return $0.resource is MedicationOrder }
                            .map() { return $0.resource as! MedicationOrder }
                        
                        // now `meds` holds all known patient prescriptions
                    }
                }
 */
            }
        }
    }

}
 */
