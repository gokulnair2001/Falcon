//
//  Main.swift
//  Falcon
//
//  Created by Gokul Nair on 27/11/21.
//

import SwiftUI

struct Main: View {
    
    @State var selectedScreen: ScreenType = .home
    
    var body: some View {
        HStack(spacing: 0) {
            
            SideBar(currentTab: $selectedScreen)
            
            switch selectedScreen {
            case .home:
                Home()
            case .settings:
                Settings()
            case .history:
                History()
            case .docs:
                Documentation()
            }
        }
        .background(Color("BG"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
