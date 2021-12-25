//
//  Cluster.swift
//  Falcon
//
//  Created by Gokul Nair on 22/12/21.
//

import SwiftUI

struct Cluster: View {
    
    @State private var searchString = ""
    
    var body: some View {
        
        VStack(alignment: .leading){

            HStack {
                Text("CLUSTER")
                    .font(.headline)
                    .foregroundColor(Color(keys.basicColor))
                    .padding()
                
                Spacer()
                
                Button{
                    print("Add new cluster")
                }label: {
                    Image(systemName: "folder.badge.plus")
                        .resizable()
                        .font(Font.title.weight(.light))
                        .foregroundColor(.black.opacity(0.7))
                        .frame(width: 18, height: 18)
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
                    List(ClusterModel.stubs, id: \.id){ data in
                        NavigationLink(destination: ClusterDetail(clusterDetails: data)) {
                            Text(data.title)
                                .foregroundColor(.black)
                        }
                    }.padding()
                        //.background(.black.opacity(0.04))
                        //.cornerRadius(8)
                }
            }
            
        }.background(Color(.white))
            .cornerRadius(5)
            .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 0)
            .frame(width: getRect().width/5.5)
    }
    
    /// Toggle switch to hide Cluster Side Bar
    func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
}

struct Cluster_Previews: PreviewProvider {
    static var previews: some View {
        Home(isShowingCluster: true)
            .frame(width: 1000, height: 800, alignment: .center)
    }
}

extension ClusterModel {
    static var stubs:[ClusterModel] = [
        ClusterModel(title: "EVO", APIs: [Collection(name: "Get Events", type: .GET, url: "www.get"),Collection(name: "Get Clubs", type: .GET, url: "www.getClubs"),Collection(name: "Get Explore", type: .GET, url: "www.explore")]), ClusterModel(title: "Dock!", APIs: [Collection(name: "Get Docks", type: .GET, url: "www.getDocks"),Collection(name: "Delete Docks", type: .DELETE, url: "www.deleteDocks")])
    ]
}
