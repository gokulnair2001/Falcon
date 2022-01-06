//
//  RoutesForm.swift
//  Falcon
//
//  Created by Gokul Nair on 06/01/22.
//

import SwiftUI

struct RoutesForm: View {
    
    @State var requestType: RequestType = .GET
    
    @State var routeTitle:String = ""
    @State var routeURL:String = ""
    
    @Binding var isShowingRoutesForm: Bool
    
    var body: some View {
        ZStack {
            Color.white
            
            VStack {
                HStack {
                    Text("Route form")
                        .font(.body)
                        .bold()
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button {
                        isShowingRoutesForm.toggle()
                    }label: {
                        Text("Close")
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                }
                
                TextField("", text: $routeTitle)
                    .placeholder(when: routeTitle.isEmpty, placeholder: {
                        Text(" Route title")
                            .foregroundColor(.black.opacity(0.4))
                            .padding(2)
                    })
                    .frame(height: 30)
                    .foregroundColor(.black)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5)
                    .padding(.bottom, 2)
                
                
                
                ZStack(alignment: .topLeading) {
                    
                    DropDown(requestType: $requestType)
                        .padding(.top, 1)
                    
                    HStack {
                        TextField("", text: $routeURL)
                            .placeholder(when: routeURL.isEmpty, placeholder: {
                                Text(" Route URL")
                                    .foregroundColor(.black.opacity(0.4))
                                    .padding(2)
                            })
                            .frame(height: 30)
                            .foregroundColor(.black)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(5)
                            .padding(.leading, 90)
                    }
                }
                
                Spacer()
                
                Button {
                    print("Addded")
                }label: {
                    Text("Add")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width:200, height: 40)
                        .background(Color.orange)
                        .cornerRadius(10)
                        .FShadow(radius: 10)
                    
                }.buttonStyle(.plain)
                    .padding(3)
                
            }.padding()
                .textFieldStyle(.plain)
                .buttonStyle(.plain)
        }.FShadow(radius: 9)
    }
}

struct RoutesForm_Previews: PreviewProvider {
    static var previews: some View {
        RoutesForm(isShowingRoutesForm: .constant(false))
    }
}
