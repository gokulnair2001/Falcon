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
    let children: [cluster]?
}
