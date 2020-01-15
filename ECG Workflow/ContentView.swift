//
//  ContentView.swift
//  ECG Workflow
//
//  Created by Yannick Börner on 15.01.20.
//  Copyright © 2020 Berlin Institute of Health. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image("heart-rate")
                .resizable()
                .scaledToFit()
            Text("1.\nOpen the Health App").multilineTextAlignment(.center)
            Divider()
            Text("2.\nTap your profile on the upper right").multilineTextAlignment(.center)
            Divider()
            Text("3.\nScroll to the bottom ").multilineTextAlignment(.center)
            Divider()
            Text("4.\nChoose 'Export All Health Data'").multilineTextAlignment(.center)
            Divider()
            Text("5.\nTap ECG Connector on the list").multilineTextAlignment(.center)
            }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
