//
//  Home.swift
//  Falcon
//
//  Created by Gokul Nair on 18/12/21.
//

import SwiftUI

struct Home: View {
    
    @State private var urlString = ""
    @State private var jsonResponse = " []"
    @State private var requestType: RequestType = .GET
    @State private var jsonFormatType: JsonFormatTypes = .pretty
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color("BG")
            
            VStack(spacing: 10) {
                
                HStack(spacing: 10) {
                    
                    TextField("", text: $urlString)
                        .placeholder(when: urlString.isEmpty, placeholder: {
                            Text(" URL").foregroundColor(.gray)
                        })
                        .frame(height: 30)
                        .background(.black.opacity(0.05))
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                        .foregroundColor(.black).opacity(0.6)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                        .overlay{
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(.black.opacity(0.2), lineWidth: 1)
                        }.textFieldStyle(.plain)
                    
                    Button{
                        if urlString != "" {
                            SendRequest(urlString)
                        }
                    }label: {
                        Text("SEND")
                            .font(.body)
                            .foregroundColor(.white)
                            .frame(width: 90, height: 35, alignment: .center)
                            .background(.blue)
                            .cornerRadius(5)
                    }
                }.padding(.leading, 100)
                    .padding([.top, .trailing], 10)
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    HStack(spacing: 0) {
                        ForEach([JsonFormatTypes.pretty, JsonFormatTypes.raw, JsonFormatTypes.basic], id: \.self) {formats in
                            jsonFormatButtons(type: formats)
                        }
                    }.cornerRadius(4)
                    
                    ScrollView {
                        Text(jsonResponse)
                            .font(.body)
                            .foregroundColor(.black)
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                            .border(.black.opacity(0.03))
                            .frame(minWidth: 200, idealWidth: 450, maxWidth: .infinity, minHeight: 400, idealHeight: getRect().height-100, maxHeight: .infinity, alignment: .topLeading)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .background(.black.opacity(0.08))
                    }
                }.padding()
            }
            
            DropDown(requestType: $requestType)
                .padding([.top, .leading], 13)
            
        }
        .ignoresSafeArea()
        .frame(minWidth: 450, idealWidth: 550, maxWidth: .infinity, minHeight: 600, idealHeight: 650, maxHeight: .infinity, alignment: .center)
        .buttonStyle(.borderless)
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
    
    @ViewBuilder
    func jsonFormatButtons(type: JsonFormatTypes) -> some View {
        Button{
            withAnimation {
                jsonFormatType = type
            }
        }label: {
            Text(type.rawValue)
                .font(.footnote)
                .foregroundColor(type == jsonFormatType ? .white : .black)
                .frame(width: 80, height: 25)
                .background(type == jsonFormatType ? Color(keys.basicColor) : Color(keys.basicColor).opacity(0.22))
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
