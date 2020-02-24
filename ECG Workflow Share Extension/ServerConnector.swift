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
            baseURL: URL(string: "http://localhost:8080")!,
            settings: [
                //"client_id": "my_mobile_app",       // if you have one
                "redirect": "smartapp://callback",    // must be registered
            ]
        )
    }
    
    func sendObservationsToServer(observations: [Observation]) {
        smartConnection.ready() { error in
            if nil != error {
                print("Connection to the server couldn't be established properly")
            }
            else {
                for observation in observations {
                    observation.create(self.smartConnection.server) { error in
                        if nil != error {
                            print("Failing during sending")
                        } else {
                            print("Observation successfully sent!")
                        }
                    }
                }
            }
        }
    }
}
