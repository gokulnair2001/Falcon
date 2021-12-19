//
//  TabBar.swift
//  Falcon
//
//  Created by Gokul Nair on 18/12/21.
//

import SwiftUI

struct TabBar: View {
    
    @State private var isConnected = false
    @Binding var isShowingSupportView: Bool
    
    var body: some View {
        ZStack() {
            Color("BG")
            HStack {
                
                Link(destination: URL(string: "https://github.com/Loafjet/Loafjet")!) {
                    Image("Github")
                        .resizable()
                        .frame(width: 23, height: 23, alignment: .center)
                        .padding(.leading, 10)
                }
                
                Spacer()
                
                HStack(spacing: 15) {
                    Image(systemName: "network")
                        .font(Font.title.weight(.light))
                        .foregroundColor(isConnected ? .green : .red)
                        .frame(width: 25, height: 25, alignment: .center)
                    
                        .onTapGesture {
                            isConnected = NetworkConnection.Connection() ? true : false
                        }
                    
                    Button{
                        withAnimation {
                            isShowingSupportView.toggle()
                        }
                    }label: {
                         Image(systemName: "questionmark.circle")
                            .font(Font.title.weight(.regular))
                            .foregroundColor(.black).opacity(0.6)
                            .frame(width: 25, height: 25, alignment: .center)
                            
                    }.buttonStyle(.borderless)
                }
            }.padding(15)
            
        }.frame(minWidth: 450, idealWidth: 550, maxWidth: .infinity, minHeight: 35, idealHeight: 35, maxHeight: 35, alignment: .center)
        
            .onAppear {
                isConnected = NetworkConnection.Connection() ? true : false
            }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(isShowingSupportView: .constant(false))
    }
}
