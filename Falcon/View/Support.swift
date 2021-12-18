//
//  Support.swift
//  Falcon
//
//  Created by Gokul Nair on 18/12/21.
//

import SwiftUI

struct Support: View {
    
    @Binding var isShowingSupportView: Bool
    
    var body: some View {
        ZStack {
            Color.red
            Button{
                withAnimation {
                    isShowingSupportView = false
                }
            }label: {
                Text("dismiss")
                    .foregroundColor(Color.black)
            }
        }.frame(minWidth: 400, idealWidth: 400, maxWidth: 400, minHeight: 500, idealHeight: 500, maxHeight: 500, alignment: .center)
    }
}

struct Support_Previews: PreviewProvider {
    static var previews: some View {
        Support(isShowingSupportView: .constant(true))
    }
}
