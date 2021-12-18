//
//  Profile.swift
//  Falcon
//
//  Created by Gokul Nair on 18/12/21.
//

import SwiftUI

struct Profile: View {
    
    var body: some View {
        ZStack {
            Color("BG")
            Text("PROFILE")
                .foregroundColor(.black)
                .bold()
        }.ignoresSafeArea()
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
