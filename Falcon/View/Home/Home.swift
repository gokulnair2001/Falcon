//
//  Home.swift
//  Falcon
//
//  Created by Gokul Nair on 18/12/21.
//

import SwiftUI

struct Home: View {
    
    @State private var urlString = "https://vit-events-app.herokuapp.com/events/likeNew"//"https://mocky.io/v2/5e2703792f00000d00a4f91d"
    @State private var bodyText = ""
    @State private var jsonResponse = " []"
    @State private var requestType: RequestType = .GET
    @State private var jsonFormatType: JsonFormatTypes = .raw
    @State private var statusCodeResponseString = "Send Request"
    @State private var statusCodeResponse: Int = 0
    @State private var dataSize: String = "0 bytes"
    @State private var responseTime: TimeInterval = 0
    
    @State var isShowingCluster: Bool
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
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
                                SendRequest(with: urlString, type: requestType)
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
                    
                    ZStack {
                        VStack(alignment: .leading, spacing: 5) {
                            
                            ZStack {
                                
                                HStack(alignment: .top) {
                                    
                                    TextEditor(text: $bodyText)
                                        .placeholder(when: urlString.isEmpty, placeholder: {
                                            Text("Body").foregroundColor(.black)
                                        })
                                        .font(.custom("Avenir Medium", size: 15))
                                        .frame(height: 250)
                                        .multilineTextAlignment(.leading)
                                        .foregroundColor(.black)
                                        .background(Color.white)
                                        .padding(5)
                                    
                                }.frame(height: 250)
                                
                            }.FShadow(radius: 7)
                            
                            Spacer()
                            
                            ZStack {
                                
                                VStack(alignment: .leading) {
                                    
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
                                                .truncationMode(.head)
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
                                        .frame(height: 30)
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
                            }.FShadow(radius: 9)
                        }
                    }
                }
                
                if isShowingCluster {
                    
                    Spacer()
                    Spacer()
                    
                    Cluster()
                }
                
                Spacer()
                Spacer()
                
                VerticalTabBar(isShowing: $isShowingCluster)
            }
            
            DropDown(requestType: $requestType)
                .padding([.top, .leading], 13)
            
        }
        .ignoresSafeArea()
        .frame(minWidth: 450, idealWidth: 550, maxWidth: .infinity, minHeight: 600, idealHeight: 650, maxHeight: .infinity, alignment: .center)
        .buttonStyle(.borderless)
    }
    
    func SendRequest(with url: String, type requestType: RequestType) {
        
        switch requestType {
        case .POST:
            postData(with: url)
        case .GET:
            getData(with: url)
        case .DELETE:
            print("DELETE")
        case .UPDATE:
            print("UPDATE")
        }
        
       
    }
    
    func getData(with url: String) {
        HTTPUtility.shared.getData(url: url) { response in
            switch response {
            case .success(let data):
                formatJSON(data: data.data!, type: jsonFormatType)
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
    
    func postData(with url: String) {
        HTTPUtility.shared.postData(url: url, parameters: bodyText) { response in
            switch response {
            case .success(let data):
                //formatJSON(data: data.data!, type: jsonFormatType)
                jsonResponse = String(data: data.data!, encoding: String.Encoding.utf8)!
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
    
    func formatJSON(data: Data, type jsonFormat: JsonFormatTypes) {
        
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
              //  SendRequest(url: urlString, requestType: <#RequestType#>)
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
            Home(isShowingCluster: true)
                .frame(width: 1100, height: 800, alignment: .center)
        }
    }
}
