//
//  ClusterDetail.swift
//  Falcon
//
//  Created by Gokul Nair on 24/12/21.
//

import SwiftUI

struct ClusterDetail: View {
    
    @State var ClusterName: String
    
    var body: some View {
        VStack{
            Text(ClusterName)
                .foregroundColor(.black)
                .font(.headline)
            
//            List([], id: \.self) { api in
//
//                HStack {
//                    Text(api.type.rawValue)
//                        .foregroundColor(requestColorCode(with: api.type))
//                        .font(.caption2)
//                        .bold()
//                        .frame(width: 40, alignment: .leading)
//
//                    Text(api.name)
//                        .foregroundColor(.black.opacity(0.7))
//                        .font(.body)
//                        .padding(.leading, 5)
//
//                    Spacer()
//                }
//            }
        }
    }
}

struct ClusterDetail_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.white
           // ClusterDetail(clusterDetails: .init(title: "Test", APIs: [Collection(name: "Test name", type: .GET, url: "Test url")]))
             ClusterDetail(ClusterName: "Dock!")
        }.frame(width: 300, height: 900)
    }
}
