//
//  TabBar.swift
//  Falcon
//
//  Created by Gokul Nair on 18/12/21.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        ZStack(alignment: .trailing) {
            Color("BG")
           Image(systemName: "network")
                .font(Font.title.weight(.light))
                .foregroundColor(Color.red)
                .padding(.trailing, 20)
                .frame(width: 25, height: 25, alignment: .center)
                
        }.frame(minWidth: 450, idealWidth: 550, maxWidth: .infinity, minHeight: 35, idealHeight: 35, maxHeight: 35, alignment: .center)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
