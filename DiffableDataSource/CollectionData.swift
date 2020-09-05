//
//  CollectionData.swift
//  DiffableDataSource
//
//  Created by Jaedoo Ko on 2020/09/01.
//  Copyright © 2020 jko. All rights reserved.
//

import Foundation

enum Section: Hashable {
    case inProgress
    case completed
}

struct Todo: Hashable {
    let id: Int
    let title: String
    let isCompleted: Bool
}
