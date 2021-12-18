//
//  Home.swift
//  Falcon
//
//  Created by Gokul Nair on 18/12/21.
//

import SwiftUI

struct Home: View {
    
    @State private var urlString = ""
    @State private var jsonResponse = ""
    
    var body: some View {
        ZStack(alignment: .top) {
            Color("BG")
            
            VStack(spacing: 10) {
                HStack(spacing: 10) {
                    
                    TextField("URL", text: $urlString)
                        .foregroundColor(.black).opacity(0.6)
                    
                    
                    Button{
                        if urlString != "" {
                            SendRequest(urlString)
                        }
                    }label: {
                        Text("GET")
                            .font(.body)
                            .foregroundColor(.white)
                            .frame(width: 90, height: 35, alignment: .center)
                            .background(.black)
                            .cornerRadius(5)
                    }.buttonStyle(.borderless)
                }.padding(10)
                
                ScrollView {
                    Text(jsonResponse)
                        .foregroundColor(.black)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                        .border(.black.opacity(0.03))
                }
            }
        }
        .ignoresSafeArea()
        .frame(minWidth: 450, idealWidth: 550, maxWidth: .infinity, minHeight: 600, idealHeight: 650, maxHeight: .infinity, alignment: .center)
        .padding(5)
    }
    
    func SendRequest(_ url: String) {
        HTTPUtility.shared.getData(url: url) { response in
            switch response {
            case .success(let data):
                getJSON(data: data)
            case .failure(let error):
                jsonResponse = "⚠️ ERROR: \(error.localizedDescription)"
            }
        }
    }
    
    func getJSON(data: Data) {
        let jsonString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
        jsonResponse = jsonString
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
