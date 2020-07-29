//
//  ContentView.swift
//  SimpleHealth
//
//  Created by Richard Sprague on 7/27/20.
//  Copyright © 2020 Richard Sprague. All rights reserved.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    @State private var selection = 0

    let heartRateQuantity = HKUnit(from: "count/min")
    
    @State private var value = 0
 
    var body: some View {
        TabView(selection: $selection){
            SHHRView()
                .tabItem {
                    VStack {
                        Image("first")
                        Text("Home")
                    }
                }
                .tag(0)
            Text("Results")
                .font(.title)
                .tabItem {
                    VStack {
                        Image("Chart_Up")
                        Text("Results")
                    }
                }
                .tag(1)
            SHSettingsView()
                .font(.title)
                .tabItem {
                    VStack {
                        Image("config30x30")
                        Text("Settings")
                    }
                }
                .tag(2)
        }
    }
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
