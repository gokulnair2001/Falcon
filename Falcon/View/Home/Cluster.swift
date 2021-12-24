//
//  Cluster.swift
//  Falcon
//
//  Created by Gokul Nair on 22/12/21.
//

import SwiftUI

struct Cluster: View {
    
    let clusters: [cluster]
    
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
                    Image(systemName: "plus")
                        .font(Font.title.weight(.regular))
                        .foregroundColor(Color(keys.basicColor))
                        .frame(width: 20)
                }
            }.padding([.leading, .trailing], 5)
            
            List(clusters, children: \.APIs){
               // OutlineGroup{
                    Text($0.title)
                        .foregroundColor(.black.opacity(0.8))
                        .frame(height: 25)
               // }
                
            }
        }.background(Color(.white))
            .cornerRadius(5)
            .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 0)
            .frame(width: getRect().width/6)
    }
}

struct Cluster_Previews: PreviewProvider {
    static var previews: some View {
        Home(isShowingCluster: true)
            .frame(width: 1000, height: 800, alignment: .center)
    }
}

extension cluster {
    static var stubs:[cluster] = [
        cluster(title: "2", APIs: [cluster(title: "22", APIs: [cluster(title: "222", APIs: nil)]),cluster(title: "22", APIs: [cluster(title: "222", APIs: nil)]),cluster(title: "22", APIs: [cluster(title: "222", APIs: nil)]),cluster(title: "22", APIs: [cluster(title: "222", APIs: nil)])]),
        cluster(title: "3", APIs: [cluster(title: "33", APIs: nil)])
    ]
}
