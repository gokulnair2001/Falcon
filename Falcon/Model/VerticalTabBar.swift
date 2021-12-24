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
                Image(systemName: isShowing ? "square.lefthalf.filled" : "square.righthalf.filled")
                    .font(Font.title.weight(.light))
                    .foregroundColor(.black)
                    .frame(width: 30, height: 30)
            }
            .buttonStyle(.borderless)
            
            Spacer(minLength: 2)
            
        }.background(Color(.white))
        .cornerRadius(5)
        .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 0)
    }
}

struct VerticalTabBar_Previews: PreviewProvider {
    static var previews: some View {
        VerticalTabBar(isShowing: .constant(true))
    }
}
