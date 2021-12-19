//
//  DropDown.swift
//  Falcon
//
//  Created by Gokul Nair on 19/12/21.
//

import SwiftUI

struct DropDown: View {
    
    @Binding var requestType: RequestType
    
    @State private var isExpanded:Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            HStack {
                Text(requestType.rawValue)
                    .font(.body)
                    .foregroundColor(requestColor(with: requestType))
                    .frame(width: 80, height: 30, alignment: .center)
                    .background(Color("DropDown"))
                    .overlay{
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color("DropDown"))
                    }
                    
                   
            }.onTapGesture {
                withAnimation {
                    self.isExpanded.toggle()
                }
            }
            
            if isExpanded {
                ScrollView {
                    ForEach([RequestType.GET, RequestType.POST, RequestType.DELETE, RequestType.UPDATE], id: \.self){button in
                        RequestButtonBuilder(type: button)
                    }
                }.frame(maxHeight: 140)
            }
        }
        .background(Color("DropDown"))
        .cornerRadius(4)
        
    }
    
    @ViewBuilder
    func RequestButtonBuilder(type: RequestType) -> some View {
        Text(type.rawValue)
            .foregroundColor(requestColor(with: type))
           // .foregroundColor(.black)
            .overlay{
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color("DropDown"))
            }
            .padding(5)
        
            .onTapGesture {
                requestType = type
                
                withAnimation {
                    self.isExpanded.toggle()
                }
            }
    }
    
    func requestColor(with request: RequestType) -> Color{
        switch request {
        case .POST:
            return .green
        case .GET:
            return .orange
        case .DELETE:
            return .red
        case .UPDATE:
            return .blue
        }
    }
}

struct DropDown_Previews: PreviewProvider {
    static var previews: some View {
        DropDown(requestType: .constant(.GET))
    }
}
