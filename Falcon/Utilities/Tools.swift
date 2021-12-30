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

//MARK: - Extension to make all List background transparent
extension NSTableView {
    open override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        
        backgroundColor = NSColor.clear
        if let esv = enclosingScrollView {
            esv.drawsBackground = false
        }
    }
}

//MARK: - Request Color Code
extension View {
    func requestColorCode(with request: RequestType) -> Color{
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

//MARK: - Default Shadow Modifier

struct FalconShadow: ViewModifier {
    
    @State var radius:CGFloat = 9
    
    func body(content: Content) -> some View {
        content
            .background(.white)
            .cornerRadius(radius)
            .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 0)
    }
}

extension View {
    func FShadow(radius: CGFloat) -> some View {
        modifier(FalconShadow(radius: radius))
    }
}
