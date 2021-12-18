//
//  SideBar.swift
//  Falcon
//
//  Created by Gokul Nair on 18/12/21.
//

import SwiftUI

struct SideBar: View {
   
    @Binding var currentTab: ScreenType
    @Namespace var animation
    
    var body: some View {
        
        ZStack {
            
            HStack{
                
                VStack {
                    VStack(spacing: 10) {
                        
                        ForEach([ScreenType.home, ScreenType.docs, ScreenType.history, ScreenType.settings], id: \.self){image in
                            MenuButtons(image: image)
                        }
                        
                    }
                    .padding(.top, 60)
                    .frame(width: 85)
                    .frame(maxHeight: .infinity, alignment: .top)

                    
                    VStack(spacing: 10) {
                        // Profile Section
                        Image("DP")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                        //.padding()
                    }.onTapGesture {
                        currentTab = .profile
                    }
                    
                    Text("F A L C O N")
                        .foregroundColor(.black)
                        .font(.caption2)
                        .padding(.bottom, 5)
                    
                }.background(
                    ZStack {
                        Color.white
                            .padding(.trailing, 30)
                        
                        Color.white
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 0)
                    }
                )
                
            }
            .frame(minWidth: 85, idealWidth: 85, maxWidth: 85, minHeight: 300, idealHeight: 500, maxHeight: .infinity, alignment: .center)
            .background(Color("BG").ignoresSafeArea())
            
            
            .buttonStyle(BorderlessButtonStyle())
            
        }
        
    }
    
    /// Side Bar Button builder
    @ViewBuilder
    func MenuButtons(image: ScreenType) -> some View{
        Image(systemName: image.rawValue)
            .resizable()
            .renderingMode(.template)
            .aspectRatio(contentMode: .fit)
            .foregroundColor(currentTab == image ? .black : .gray)
            .frame(width: 22, height: 22)
            .frame(width: 80, height: 50)
            .overlay(
                HStack {
                    if currentTab == image {
                        Capsule()
                            .fill(Color.black)
                            .matchedGeometryEffect(id: "TAB", in: animation)
                            .frame(width: 2, height: 40)
                    }
                }
                , alignment: .trailing
            )
            .contentShape(Rectangle())
        
            .onTapGesture {
                withAnimation(.spring()){
                    currentTab = image
                }
            }
    }
}

//struct SideBar_Previews: PreviewProvider {
//    static var previews: some View {
//        Main(selectedScreen: .home)
//    }
//}
