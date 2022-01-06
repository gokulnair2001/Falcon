//
//  ClusterDetail.swift
//  Falcon
//
//  Created by Gokul Nair on 24/12/21.
//

import SwiftUI

struct ClusterDetail: View {

    @State var ClusterName: String
    
    @Binding var isShowingRoutesForm: Bool
    
    var body: some View {
        VStack{
            
            HStack {
                
                Text(ClusterName)
                    .foregroundColor(.black)
                    .font(.headline)
                
                Spacer()
                
                Button{
                    print("add")
                    withAnimation {
                        isShowingRoutesForm.toggle()
                    }
                    
                }label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .font(Font.title.weight(.regular))
                        .foregroundColor(.black.opacity(0.7))
                        .frame(width: 15, height: 15)
                }
            }.padding(5)
            
          
            
            Spacer()
            
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
            ClusterDetail(ClusterName: "Dock!", isShowingRoutesForm: .constant(false))
        }.frame(width: 300, height: 900)
    }
}
