//
//  Tools.swift
//  Falcon
//
//  Created by Gokul Nair on 18/12/21.
//

import SwiftUI

extension View {
    func getRect() -> CGRect {
        return NSScreen.main!.visibleFrame
    }
}
