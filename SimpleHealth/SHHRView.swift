//
//  SHHRView.swift
//  SimpleHealth
//
//  Created by Richard Sprague on 7/27/20.
//  Copyright © 2020 Richard Sprague. All rights reserved.
//

import SwiftUI

struct SHHRView: View {
    var userHealthData = UserHealthData(message: "SHHRView")
  
    var body: some View {
        VStack{
            Text("Your Health Data" ).font(.title)
            ZStack{
                Rectangle()
                    .fill(Color(.blue))
                    .frame(width:300, height:400)
                .padding()
                VStack{
//                    Text("Heart Rate = \(self.getHR())")
//                        .foregroundColor(.white)
                    Text("Age = " + String(userHealthData.age?.description ?? "err"))
                        .foregroundColor(.white)
                    Text("Height = \(self.getHeight())")
                    .foregroundColor(.white)
                }
                
            }
            }
        }
    
    private func getAge() -> Int {
        
        let userHealthProfile = UserHealthProfile()
        
        do {
          let userAgeSexAndBloodType = try ProfileDataStore.getAgeSexAndBloodType()
          userHealthProfile.age = userAgeSexAndBloodType.age
          userHealthProfile.biologicalSex = userAgeSexAndBloodType.biologicalSex
          userHealthProfile.bloodType = userAgeSexAndBloodType.bloodType

        } catch let error {
            print("Unable to read profile data (error:" + error.localizedDescription)
        }

        
        return userHealthProfile.age ?? 0
    }
    
    private func getHeight() -> Double {
       let userHealthProfile = UserHealthProfile()
        return userHealthProfile.heightInMeters ?? 0.5

    }

}


struct SHHRView_Previews: PreviewProvider {
    static var previews: some View {
        SHHRView()
        .environmentObject(UserHealthData(message: "Preview"))
    }
}
