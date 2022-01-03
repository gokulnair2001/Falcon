//
//  Profile.swift
//  Falcon
//
//  Created by Gokul Nair on 18/12/21.
//

import SwiftUI

struct Profile: View {
    
    @StateObject private var iCloudViewModel = CloudKitUserSetupViewModel()
    
    var body: some View {
        ZStack {
            Color("BG")
            VStack {
                
                Text("\(iCloudViewModel.userName)")
                Text("\(iCloudViewModel.isSignedIn.description)")
                Text(iCloudViewModel.statusTag)
                
            }.foregroundColor(.blue)
        }.ignoresSafeArea()
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
