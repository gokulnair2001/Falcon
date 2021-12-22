//
//  Main.swift
//  Falcon
//
//  Created by Gokul Nair on 27/11/21.
//

import SwiftUI

struct Main: View {
    
    @State private var selectedScreen: ScreenType = .Home
    @State private var isShowingSupportView = false
    @State private var isShowingClusterView = true
    
    var body: some View {
        ZStack {
            HStack {
                
                SideBar(currentTab: $selectedScreen)
                
                VStack {
                    TabBar(isShowingSupportView: $isShowingSupportView)
                    
                    HStack(spacing: 10) {
                        switch selectedScreen {
                        case .Home:
                            Home(isShowingCluster: $isShowingClusterView)
                        case .Settings:
                            Settings()
                        case .History:
                            History()
                        case .Docs:
                            Documentation()
                        case .Profile:
                            Profile()
                        }
                        
                        VerticalTabBar(isShowing: $isShowingClusterView)
                    }.padding(7)
                }
            }
            
            if isShowingSupportView {
                Color(keys.basicColor).opacity(0.2)
                Support(isShowingSupportView: $isShowingSupportView)
                    .shadow(radius: 5)
            }
            
        }
        .background(Color("BG"))
        .frame(minWidth: getRect().width/1.75, idealWidth: getRect().width-200, maxWidth: getRect().width, minHeight: getRect().height-300, idealHeight: getRect().height - 130, maxHeight: getRect().height, alignment: .center)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
