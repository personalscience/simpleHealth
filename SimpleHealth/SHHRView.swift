//
//  SHHRView.swift
//  SimpleHealth
//
//  Created by Richard Sprague on 7/27/20.
//  Copyright © 2020 Richard Sprague. All rights reserved.
//

import SwiftUI

struct SHHRView: View {
    var body: some View {
        VStack{
        Text("Your Health Data").font(.title)
            ZStack{
                Rectangle()
                    .fill(Color(.blue))
                    .frame(width:300, height:400)
                .padding()
                Text("Heart Rate").foregroundColor(.white)
                
            }
            }
        }

}


struct SHHRView_Previews: PreviewProvider {
    static var previews: some View {
        SHHRView()
    }
}
