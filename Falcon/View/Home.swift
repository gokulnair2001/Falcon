//
//  Home.swift
//  Falcon
//
//  Created by Gokul Nair on 18/12/21.
//

import SwiftUI

struct Home: View {
    
    @State private var urlString = "https://mocky.io/v2/5e2703792f00000d00a4f91d"
    @State private var jsonResponse = " []"
    @State private var requestType: RequestType = .GET
    @State private var jsonFormatType: JsonFormatTypes = .raw
    @State private var statusCodeResponseString = "Send Request"
    @State private var statusCodeResponse: Int = 0
    @State private var dataSize: String = "0 bytes"
    @State private var responseTime: TimeInterval = 0
    
    @Binding var isShowingCluster: Bool
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            Color(.white)
                .cornerRadius(11)
                .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 0)
            
            HStack {
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
                    
                    VStack(alignment: .leading, spacing: 5) {
                        
                        HStack {
                            HStack(spacing: 0.5) {
                                ForEach([JsonFormatTypes.pretty, JsonFormatTypes.raw, JsonFormatTypes.basic], id: \.self) {formats in
                                    jsonFormatButtons(type: formats)
                                }
                            }.cornerRadius(5)
                            
                            
                            Spacer()
                            
                            HStack {
                                
                                Text("Request:")
                                    .foregroundColor(.black.opacity(0.6))
                                Text("\(statusCodeResponse)  \(statusCodeResponseString)")
                                    .foregroundColor(keys.customGreen)
                                    .padding(.leading, 5)
                                
                                Text("Size:")
                                    .foregroundColor(.black.opacity(0.6))
                                    .padding(.leading, 5)
                                Text(dataSize)
                                    .foregroundColor(keys.customGreen)
                                    .padding(.trailing, 5)
                                
                                Text("Time:")
                                    .foregroundColor(.black.opacity(0.6))
                                Text("\(responseTime) s")
                                    .foregroundColor(keys.customGreen)
                                    .padding(.trailing, 5)
                            }
                            .font(.caption)
                            
                        }
                        
                        FDivider(color: .gray, width: 1)
                        
                        ScrollView {
                            Text(jsonResponse)
                                .font(.body)
                                .foregroundColor(.black)
                                .lineLimit(nil)
                                .multilineTextAlignment(.leading)
                               
                            Spacer()
                            
                        }
                        
                    }.padding()
                        .background(Color(keys.basicColor).opacity(0.03))
                        .cornerRadius(13)
                }
                
                if isShowingCluster {
                    Cluster(clusters: cluster.stubs)
                }
            }//.padding()
            
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
                getJSON(data: data.data!, type: jsonFormatType)
                dataSize = "\(data.data!)"
                statusCodeResponseString = data.httpStatusCodeDescription!
                statusCodeResponse = data.httpStatusCode!
                responseTime = data.responseTime!
                
            case .failure(let error):
                dataSize = "0 bytes"
                responseTime = 0
                statusCodeResponseString = error.serverResponse!
                statusCodeResponse = error.httpStatusCode!
                jsonResponse = "⚠️ ERROR: \(error.localizedDescription)"
            }
        }
    }
    
    func getJSON(data: Data, type jsonFormat: JsonFormatTypes) {
        
        switch jsonFormat {
        case .raw:
            jsonResponse = NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
        case .pretty:
            jsonResponse = "Upcoming feature"
        case .basic:
            jsonResponse = "Upcoming feature"
        }
    }
    
    @ViewBuilder
    func jsonFormatButtons(type: JsonFormatTypes) -> some View {
        Button{
            withAnimation {
                jsonFormatType = type
                SendRequest(urlString)
            }
        }label: {
            Text(type.rawValue)
                .font(.footnote)
                .foregroundColor(type == jsonFormatType ? .orange : .black)
                .frame(width: 80, height: 25)
                .background(type == jsonFormatType ? Color(keys.basicColor) : Color(keys.basicColor).opacity(0.22))
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.white)
            Home(isShowingCluster: .constant(true))
                .frame(width: 800, height: 900, alignment: .center)
        }
    }
}
