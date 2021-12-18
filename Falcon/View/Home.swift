//
//  Home.swift
//  Falcon
//
//  Created by Gokul Nair on 18/12/21.
//

import SwiftUI

struct Home: View {
    var body: some View {
        ZStack {
            Color("BG")
//            Text("Home View")
//                .foregroundColor(.black)
            Button{
                call()
            }label: {
                Text("GET")
                    .foregroundColor(.black)
            }.buttonStyle(.borderless)
            
        }
        .ignoresSafeArea()
        .frame(minWidth: 450, idealWidth: 550, maxWidth: .infinity, minHeight: 600, idealHeight: 650, maxHeight: .infinity, alignment: .center)
    }
    
    func call() {
        HTTPUtility.shared.getData(url: "https://mocky.io/v2/5e2703792f00000d00a4f91d") { response in
            switch response {
            case .success(let data):
                print("❌\(data)")
            case .failure(let error):
                print("⚠️\(error)")
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
