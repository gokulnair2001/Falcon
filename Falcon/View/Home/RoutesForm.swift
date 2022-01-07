//
//  RoutesForm.swift
//  Falcon
//
//  Created by Gokul Nair on 06/01/22.
//

import SwiftUI

struct RoutesForm: View {
    
    @Binding var isShowingRoutesForm: Bool
    
    @StateObject private var iCloudRouteModel = iCloudClusterModel()
    
    var body: some View {
        ZStack {
            Color.white
            
            VStack {
                HStack {
                    
                    Image(systemName: "bolt.horizontal.icloud")
                        .resizable()
                        .foregroundColor(.blue)
                        .font(Font.title.weight(.medium))
                        .frame(width: 20, height: 15, alignment: .center)
                    
                    Text(ClusterDetail.selectedClusterName)
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
                
                TextField("", text: $iCloudRouteModel.routeTitle)
                    .placeholder(when: iCloudRouteModel.routeTitle.isEmpty, placeholder: {
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
                    
                    DropDown(requestType: $iCloudRouteModel.routeType)
                        .padding(.top, 1)
                    
                    HStack {
                        TextField("", text: $iCloudRouteModel.routeURL)
                            .placeholder(when: iCloudRouteModel.routeURL.isEmpty, placeholder: {
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
                    iCloudRouteModel.clusterName = ClusterDetail.selectedClusterName
                    iCloudRouteModel.addRouteButtonPressed()
                    
                    if !iCloudRouteModel.isRoutesSaved {
                        isShowingRoutesForm.toggle()
                    }
                    
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
