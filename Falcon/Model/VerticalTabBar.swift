//
//  VerticalTabBar.swift
//  Falcon
//
//  Created by Gokul Nair on 22/12/21.
//

import SwiftUI

struct VerticalTabBar: View {
    
    @Binding var isShowing:Bool
    
    var body: some View {
        VStack {
            
            Button{
                withAnimation {
                    isShowing.toggle()
                }
            }label: {
                Image(systemName: "square.lefthalf.filled")
                    .font(Font.title.weight(.light))
                    .foregroundColor(.black)
                    .frame(width: 30, height: 30)
            }
            .buttonStyle(.borderless)
            
            Spacer(minLength: 2)
            
        }.background(.black.opacity(0.15))
        .cornerRadius(5)
    }
}

struct VerticalTabBar_Previews: PreviewProvider {
    static var previews: some View {
        VerticalTabBar(isShowing: .constant(true))
    }
}
