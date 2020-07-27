//
//  SHSettingsView.swift
//  SimpleHealth
//
//  Created by Richard Sprague on 7/27/20.
//  Copyright © 2020 Richard Sprague. All rights reserved.
//

import SwiftUI

struct SHSettingsView: View {
    
    // private var authorized: Bool
    
    var body: some View {
        VStack{
        Text("Settings")
            .font(.title)
            .padding()
        Spacer()
            Button(action: {self.authorizeHealthKit() }){
                Text("Authorize Health Kit")
                
            }
        Spacer()
        }
    }
    
    private func authorizeHealthKit() {
      HealthKitSetupAssistant.authorizeHealthKit { (authorized, error) in
            
        guard authorized else {
              
          let baseMessage = "HealthKit Authorization Failed"
              
          if let error = error {
            print("\(baseMessage). Reason: \(error.localizedDescription)")
          } else {
            print(baseMessage)
          }
              
          return
        }
            
        print("HealthKit Successfully Authorized.")
      }
    }
}

struct SHSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SHSettingsView()
    }
}
