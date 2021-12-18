//
//  History.swift
//  Falcon
//
//  Created by Gokul Nair on 18/12/21.
//

import SwiftUI

struct History: View {
    var body: some View {
        ZStack {
            Color("BG")
            Text("History View")
                .foregroundColor(.black)
        }
        .ignoresSafeArea()
        .frame(minWidth: 450, idealWidth: 550, maxWidth: .infinity, minHeight: 600, idealHeight: 650, maxHeight: .infinity, alignment: .center)
    }
}

struct History_Previews: PreviewProvider {
    static var previews: some View {
        History()
    }
}
