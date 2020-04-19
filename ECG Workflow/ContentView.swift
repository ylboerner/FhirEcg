//
//  ContentView.swift
//  ECG Workflow
//
//  Created by Yannick Börner on 15.01.20.
//  Copyright © 2020 Berlin Institute of Health. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var serverAddress: String = ""
    @State var patientReference: String = ""
    
    var body: some View {
        ScrollView(Axis.Set.vertical, showsIndicators: true) {
            VStack {
                VStack {
                    Image("1-01-transparent-cropped")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                    TextField("Server address", text: $serverAddress).multilineTextAlignment(.center)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Patient reference", text: $patientReference).multilineTextAlignment(.center)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                Spacer(minLength: 20)
                VStack {
                    Instruction(number: "1", instruction: "Enter a server adress and patient reference above")
                    Instruction(number: "2", instruction: "Open the Health App")
                    Instruction(number: "3", instruction: "Tap your profile on the upper right")
                    Instruction(number: "4", instruction: "Scroll to the bottom")
                    Instruction(number: "5", instruction: "Choose 'Export all Health Data'")
                    Instruction(number: "6", instruction: "Tap ECG Connector on the list")
                }
            }.padding()
        }
    }
}

struct Instruction : View {
    var number: String
    var instruction: String
    var body: some View {
        VStack() {
            Divider()
            Text(number)
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundColor(.red)
            Text(instruction)
                .multilineTextAlignment(.center)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


