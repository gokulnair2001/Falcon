//
//  Cluster.swift
//  Falcon
//
//  Created by Gokul Nair on 22/12/21.
//

import SwiftUI

struct Cluster: View {
    var body: some View {
            
            VStack(alignment: .leading){
                
                Text("CLUSTER")
                    .font(.headline)
                    .foregroundColor(Color(keys.basicColor))
                    .frame(width: getRect().width/6)
                    .padding()
                
                Spacer()
            }.background(Color(keys.basicColor).opacity(0.03))
                .cornerRadius(10)
    }
}

struct Cluster_Previews: PreviewProvider {
    static var previews: some View {
        //  Cluster()
        Home(isShowingCluster: .constant(true))
    }
}
