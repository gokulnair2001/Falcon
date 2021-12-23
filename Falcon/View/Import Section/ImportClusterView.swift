//
//  ImportCluster.swift
//  Falcon
//
//  Created by Gokul Nair on 23/12/21.
//

import SwiftUI

struct ImportClusterView: View {
    
    @State var importType: ImportTypes = .folder
    @Binding var isShowingImportView: Bool
    
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color(.white)
            
            VStack {
                ImportViewBar(importTypeSelected: $importType, isShowingMenuView: $isShowingImportView)
           
                switch importType {
                case .folder:
                    ImportFolder()
                        .padding()
                case .link:
                    ImportLink()
                        .padding()
                }
            }
            
        }.frame(width: 600, height: 500, alignment: .center)
            .cornerRadius(7)
            .padding()
    }
}

struct ImportCluster_Previews: PreviewProvider {
    static var previews: some View {
        ImportClusterView(isShowingImportView: .constant(false))
    }
}
