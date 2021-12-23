//
//  MenuBar.swift
//  Falcon
//
//  Created by Gokul Nair on 23/12/21.
//

import SwiftUI

struct MenuBar: View {
    
    @Binding var MenuSelected: MenuBarOptionTypes
    @Binding var isShowingMenuView: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color("BG")
            HStack {
                
                ForEach([MenuBarOptionTypes.Home, MenuBarOptionTypes.Import, MenuBarOptionTypes.Scout], id: \.self) {button in
                    MenuButtonBuilder(type: button)
                }
                
            }.padding(5)
            
        }.frame(minWidth: 450, idealWidth: 550, maxWidth: .infinity, minHeight: 20, idealHeight: 20, maxHeight: 20, alignment: .center)
    }
    
    @ViewBuilder
    func MenuButtonBuilder(type: MenuBarOptionTypes) -> some View {
        Button{
            isShowingMenuView = true
            MenuSelected = type
        }label: {
            Text(type.rawValue)
                .foregroundColor(.black.opacity(0.8))
                .font(.callout)
                .bold()
        }.buttonStyle(.borderless)
            .padding(10)
    }
}


struct MenuBar_Previews: PreviewProvider {
    static var previews: some View {
        MenuBar(MenuSelected: .constant(.none), isShowingMenuView: .constant(false))
    }
}
