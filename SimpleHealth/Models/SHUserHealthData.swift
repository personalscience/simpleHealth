//
//  SHUserHealthData.swift
//  SimpleHealth
//
//  Created by Richard Sprague on 7/28/20.
//  Copyright © 2020 Richard Sprague. All rights reserved.
//

import Foundation
import HealthKit

class UserHealthData: ObservableObject{
    
    private var healthKitStore = HKHealthStore()
    var age: Int?
    var biologicalSex: HKBiologicalSex?
    var bloodType: HKBloodType
    var message: String
    
    init(message:String){
        self.message = message
        // self.healthKitStore = HKHealthStore()
        self.bloodType = .aPositive
        self.biologicalSex = .male

        do {
            let birthdayComponents =  try healthKitStore.dateOfBirthComponents()
            let wrappedBiologicalSex =       try healthKitStore.biologicalSex()
            let wrappedBloodType =           try healthKitStore.bloodType()
            
            
            
            //2. Use Calendar to calculate age.
            let today = Date()
            let calendar = Calendar.current
            let todayDateComponents = calendar.dateComponents([.year],
                                                              from: today)
            let thisYear = todayDateComponents.year!
            age = thisYear - birthdayComponents.year!
            
            //3. Unwrap the wrappers to get the underlying enum values.
            biologicalSex = wrappedBiologicalSex.biologicalSex
            bloodType = wrappedBloodType.bloodType
        } catch { print("couldn't establish health data type")}
       

    }
        
        
    
}
