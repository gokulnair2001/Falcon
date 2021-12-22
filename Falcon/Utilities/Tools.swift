//
//  Tools.swift
//  Falcon
//
//  Created by Gokul Nair on 18/12/21.
//

import SwiftUI

//MARK: - To get Current Screen Dimensions
extension View {
    func getRect() -> CGRect {
        return NSScreen.main!.visibleFrame
    }
}

//MARK: - To add placeholders for TextField
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

//MARK: - Custom Divider
struct FDivider: View {
    @State var color: Color = .gray
    @State var width: CGFloat = 2
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
            .edgesIgnoringSafeArea(.horizontal)
    }
}
