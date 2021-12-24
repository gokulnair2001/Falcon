//
//  ImportViewBar.swift
//  Falcon
//
//  Created by Gokul Nair on 23/12/21.
//

import SwiftUI

struct ImportViewBar: View {
    
    @Binding var importTypeSelected:ImportTypes
   // @Binding var isShowingMenuView: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button{
                    importTypeSelected = .folder
                }label: {
                    Text(ImportTypes.folder.rawValue)
                        .foregroundColor(importTypeSelected == .folder ? .orange : Color(keys.basicColor))
                }
                
                Button{
                    importTypeSelected = .link
                }label: {
                    Text(ImportTypes.link.rawValue)
                        .foregroundColor(importTypeSelected == .link ? .orange : Color(keys.basicColor))
                }
                
                Spacer()
                
            }.buttonStyle(.borderless)
                .font(.callout)
                .foregroundColor(.black.opacity(0.6))
                .padding([.leading,.top, .trailing], 10)
            
            FDivider(color: .black, width: 0.5)
        }
    }
}

struct ImportViewBar_Previews: PreviewProvider {
    static var previews: some View {
        ZStack(alignment: .topLeading) {
            Color.white
            ImportViewBar(importTypeSelected: .constant(.folder))
        }
    }
}
