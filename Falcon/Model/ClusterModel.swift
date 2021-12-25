//
//  ClusterModel.swift
//  Falcon
//
//  Created by Gokul Nair on 23/12/21.
//

import Foundation
import SwiftUI

struct ClusterModel: Identifiable {
    let id = UUID()
    let title: String
    let APIs: [Collection]
}

struct Collection: Identifiable {
    let id = UUID()
    let name: String
    let type: RequestType
    let url: String
}
