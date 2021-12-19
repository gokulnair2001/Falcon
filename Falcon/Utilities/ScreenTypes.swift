//
//  ScreenTypes.swift
//  Falcon
//
//  Created by Gokul Nair on 18/12/21.
//

import Foundation

enum ScreenType: String {
    case Home = "rectangle.3.group"
    case Settings = "gear"
    case History = "clock.arrow.circlepath"
    case Docs = "list.bullet.rectangle"
    case Profile = "person"
    
    var title: String {
        switch self {
        case .Home:
            return "Home"
        case .Settings:
            return "Settings"
        case .History:
            return "History"
        case .Docs:
            return "Docs"
        case .Profile:
            return "Profile"
        }
    }
}

