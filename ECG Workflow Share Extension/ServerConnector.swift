//
//  ServerConnector.swift
//  ECG Workflow Share Extension
//
//  Created by Yannick Börner on 21.01.20.
//  Copyright © 2020 Berlin Institute of Health. All rights reserved.
//

import Foundation
import SMART

class ServerConnector {
    
    var smartConnection: Client
    
    init() {
        // Establish a connection to the server
        smartConnection = Client(
            // Change this URL in order to send data to another server
            baseURL: URL(string: PersistenceController.getValueFromUserDefaults(key: "serverAddress") ?? "No server address")!,
            settings: [
                //"client_id": "ECG Workflow app BIH",       // if you have one
                "redirect": "smartapp://callback",    // must be registered
            ]
        )
    }
    
    func sendObservationsToServer(observations: [EcgObservation]) {
        for observation in observations {
            observation.smartObservation!.create(self.smartConnection.server) { error in
                if nil != error {
                    print(error!)
                } else {
                    PersistenceController.markEcgAsSent(url: observation.urlToCSV)
                    print("Observation successfully sent.")
                }
            }
        }
    }
    /*
    func sendObservationsToServer(observations: [EcgObservation]) {
        smartConnection.ready() { error in
            if nil != error {
                print(error!)
            }
            else {
                for observation in observations {
                    observation.smartObservation!.create(self.smartConnection.server) { error in
                        if nil != error {
                            print(error!)
                        } else {
                            print("Observation successfully sent.")
                        }
                    }
                }
            }
        }
    }
    */
}
