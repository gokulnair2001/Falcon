//
//  ClusterModel.swift
//  Falcon
//
//  Created by Gokul Nair on 23/12/21.
//

import Foundation

struct cluster: Identifiable {
    let id = UUID()
    let title: String
    let APIs: [cluster]?
}

struct Children {
    let name: String
    let api: String
}
