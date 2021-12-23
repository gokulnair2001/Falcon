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
            
            List{
                OutlineGroup(clusters, children: \.children){
                    Text($0.title)
                        .foregroundColor(.black.opacity(0.8))
                        .frame(height: 25)
                }
                
            }
        }.background(Color(keys.basicColor).opacity(0.03))
            .frame(width: getRect().width/6)
            .cornerRadius(10)
    }
}

struct Cluster_Previews: PreviewProvider {
    static var previews: some View {
        // Cluster(clusters: cluster.stubs)
        Home(isShowingCluster: .constant(true))
            .frame(width: 1000, height: 800, alignment: .center)
    }
}

extension cluster {
    static var stubs:[cluster] = [
        cluster(title: "Evo", children: [cluster(title: "Get Events", children: nil), cluster(title: "Post Events", children: nil)]), cluster(title: "Evo", children: [cluster(title: "Get Events", children: nil), cluster(title: "Post Events", children: nil)])
    ]
}
