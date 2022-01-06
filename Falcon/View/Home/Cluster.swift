//
//  Cluster.swift
//  Falcon
//
//  Created by Gokul Nair on 22/12/21.
//

import SwiftUI

struct Cluster: View {
    
    @Binding var isShowingForm:Bool
    
    @State private var searchString = ""
    
    @StateObject private var iCloudUtility = iCloudUtilityModel()
    @StateObject private var iCloudUser = CloudKitUserSetupViewModel()
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            if iCloudUser.isSignedIn {
                
                HStack {
                    Text("CLUSTER")
                        .font(.headline)
                        .foregroundColor(Color(keys.basicColor))
                        .padding()
                    
                    Spacer()
                    
                    Button{
                        withAnimation {
                            isShowingForm.toggle()
                        }
                        
                    }label: {
                        Image(systemName: "plus")
                            .resizable()
                            .font(Font.title.weight(.regular))
                            .foregroundColor(.black.opacity(0.7))
                            .frame(width: 15, height: 15)
                    }
                    
                    Button{
                        toggleSidebar()
                    }label: {
                        Image(systemName: "align.horizontal.left")
                            .resizable()
                            .font(Font.title.weight(.regular))
                            .foregroundColor(.black.opacity(0.7))
                            .frame(width: 18, height: 18)
                    }.padding([.leading, .trailing], 5)
                    
                }.padding([.leading, .trailing], 5)
                
                NavigationView {
                    ZStack {
                        Color.white
                        List(iCloudUtility.ClusterList, id: \.self){ data in
                            NavigationLink(destination: ClusterDetail(ClusterName: data)) {
                                
                                HStack {
                                    Image(systemName: "folder")
                                        .resizable()
                                        .frame(width: 15, height: 15, alignment: .center)
                                        .font(Font.title.weight(.light))
                                        .foregroundColor(.black)
                                    
                                    Text(data)
                                        .foregroundColor(.black)
                                        .font(.caption2)
                                        .bold()
                                        .frame(height: 15)
                                        .padding(.leading, 3)
                                    
                                    Spacer()
                                }.padding(2)
                            }
                        }.padding(2)
                    }
                }
                .onAppear {
                    iCloudUtility.fetchClusters()
                }
            }else {
                Text("SignIn with your iCloud account to add clusters")
                    .foregroundColor(.black)
                    .bold()
            }
            
        }.FShadow(radius: 5)
            .frame(width: getRect().width/5.5)
    }
    
    /// Toggle switch to hide Cluster Side Bar
    func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
}

struct Cluster_Previews: PreviewProvider {
    static var previews: some View {
        // Home(isShowingCluster: true)
        //.frame(width: 1000, height: 800, alignment: .center)
        Cluster(isShowingForm: .constant(false))
    }
}

extension ClusterModel {
    static var stubs:[ClusterModel] = [ ClusterModel(title: "EVO", APIs: [Collection(name: "Get Events", type: .GET, url: "www.get"),Collection(name: "Get Clubs", type: .GET, url: "www.getClubs"),Collection(name: "Get Explore", type: .GET, url: "www.explore")]), ClusterModel(title: "Dock!", APIs: [Collection(name: "Get Docks", type: .GET, url: "www.getDocks"),Collection(name: "Delete Docks", type: .DELETE, url: "www.deleteDocks")]) ]
    
}
