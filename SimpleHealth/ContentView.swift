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
    private var healthStore = HKHealthStore()
    let heartRateQuantity = HKUnit(from: "count/min")
    
    @State private var value = 0
 
    var body: some View {
        TabView(selection: $selection){
            SHHRView()
                .font(.title)
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
    
    func start() {
         authorizeHealthKit()
         startHeartRateQuery(quantityTypeIdentifier: .heartRate)
     }
     
     func authorizeHealthKit() {
        

        
         let healthKitTypes: Set = [
         HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!]

         healthStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { _, _ in }
     }
     
     private func startHeartRateQuery(quantityTypeIdentifier: HKQuantityTypeIdentifier) {
         
         // 1
         let devicePredicate = HKQuery.predicateForObjects(from: [HKDevice.local()])
         // 2
         let updateHandler: (HKAnchoredObjectQuery, [HKSample]?, [HKDeletedObject]?, HKQueryAnchor?, Error?) -> Void = {
             query, samples, deletedObjects, queryAnchor, error in
             
             // 3
         guard let samples = samples as? [HKQuantitySample] else {
             return
         }
             
         self.process(samples, type: quantityTypeIdentifier)

         }
         
         // 4
         let query = HKAnchoredObjectQuery(type: HKObjectType.quantityType(forIdentifier: quantityTypeIdentifier)!, predicate: devicePredicate, anchor: nil, limit: HKObjectQueryNoLimit, resultsHandler: updateHandler)
         
         query.updateHandler = updateHandler
         
         // 5
         
         healthStore.execute(query)
     }
     
     private func process(_ samples: [HKQuantitySample], type: HKQuantityTypeIdentifier) {
         var lastHeartRate = 0.0
         
         for sample in samples {
             if type == .heartRate {
                 lastHeartRate = sample.quantity.doubleValue(for: heartRateQuantity)
             }
             
             self.value = Int(lastHeartRate)
         }
     }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
