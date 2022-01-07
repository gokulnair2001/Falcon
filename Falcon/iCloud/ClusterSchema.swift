//
//  ClusterSchema.swift
//  Falcon
//
//  Created by Gokul Nair on 07/01/22.
//

import Foundation

struct clusterSchema: Identifiable {
    let id = UUID()
    let title: String
    let url: String
    let type: String
}
