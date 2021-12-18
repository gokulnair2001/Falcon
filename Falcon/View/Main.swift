//
//  Main.swift
//  Falcon
//
//  Created by Gokul Nair on 27/11/21.
//

import SwiftUI

struct Main: View {
    
    @State private var selectedScreen: ScreenType = .home
    @State private var isShowingSupportView = false
    
    var body: some View {
        ZStack {
            HStack(spacing: 10) {
                
                SideBar(currentTab: $selectedScreen)
                
                VStack {
                    TabBar(isShowingSupportView: $isShowingSupportView)
                    
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
            
            if isShowingSupportView {
                Support()
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
