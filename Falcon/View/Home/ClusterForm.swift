//
//  ClusterForm.swift
//  Falcon
//
//  Created by Gokul Nair on 05/01/22.
//

import SwiftUI

struct ClusterForm: View {
    
    @StateObject private var iCloudModel = iCloudUtilityModel()
    
    @Binding var isShowingForm: Bool
    
    let color:[Color] = [.red, .green, .blue, .orange, .yellow]
   
    var body: some View {
        ZStack {
            Color.white
            
            VStack {
                
                HStack {
                   Text("Cluster form")
                        .font(.body)
                        .bold()
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button {
                        isShowingForm.toggle()
                    }label: {
                        Text("Close")
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                }
                
                TextField("", text: $iCloudModel.ClusterTitle)
                    .placeholder(when: iCloudModel.ClusterTitle.isEmpty, placeholder: {
                        Text(iCloudModel.isDuplicateCluster ? " DUPLICATE ENTRY!" : " Add a Unique Cluster")
                            .foregroundColor(iCloudModel.isDuplicateCluster ? .red.opacity(0.4) : .black.opacity(0.4))
                            .padding(2)
                    })
                    .frame(height: 45)
                    .foregroundColor(.black)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.bottom, 2)
                
                
                Text("Existing Clusters")
                    .foregroundColor(.black.opacity(0.4))
                
                ScrollView(.horizontal) {
                    HStack(spacing: 10){
                        ForEach(iCloudModel.ClusterList, id: \.self) { title in
                            
                            Text(title)
                                .foregroundColor(color.randomElement())
                                .font(.callout)
                                .padding(10)
                                .frame(height: 30)
                                //.background(.green.opacity(0.5))
                                .background(Color("DropDown"))
                                .cornerRadius(6)
                                .FShadow(radius: 6)
                        }
                    }.padding(3)
                }
                
                Spacer()
                
                Button {
                    iCloudModel.addButtonPressed()
                    
                    if !iCloudModel.isClusterSaved {
                        isShowingForm.toggle()
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
                
            }.textFieldStyle(.plain)
                .padding()
            
        }.FShadow(radius: 9)
            .onAppear {
                iCloudModel.fetchClusters()
            }
    }
}

struct NewClusterForm_Previews: PreviewProvider {
    static var previews: some View {
        ClusterForm(isShowingForm: .constant(true))
    }
}
