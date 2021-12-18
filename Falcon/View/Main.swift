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
        HStack(spacing: 10) {
            
            SideBar(currentTab: $selectedScreen)
            
            VStack {
                TabBar()
                
                switch selectedScreen {
                case .home:
                    Home()
                case .settings:
                    Settings()
                case .history:
                    History()
                case .docs:
                    Documentation()
                case .profile:
                    Profile()
                }
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
