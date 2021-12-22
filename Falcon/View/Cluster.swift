//
//  Cluster.swift
//  Falcon
//
//  Created by Gokul Nair on 22/12/21.
//

import SwiftUI

struct Cluster: View {
    var body: some View {
        
        VStack{
            Text("Cluster View")
                .foregroundColor(.white)
        }.frame(width: getRect().width/6)
            .background(.red)
        
    }
}

struct Cluster_Previews: PreviewProvider {
    static var previews: some View {
            Cluster()
    }
}
