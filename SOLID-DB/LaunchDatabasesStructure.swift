//
//  Enums.swift
//  SOLID-DB
//
//  Created by admin on 5/24/20.
//  Copyright © 2020 PL. All rights reserved.
//

import Foundation

enum LaunchDatabaseParameter: String {
    case memory        = "-memory"
    case userDefault   = "-userDefault"
    case realm         = "-realm"
    case coreData      = "-coreData"
}

struct LaunchDatabasesStructure {
    let memory      : Bool
    let userDefault : Bool
    let realm       : Bool
    let coreData    : Bool
}
