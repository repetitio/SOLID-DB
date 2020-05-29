//
//  DatabaseCreator.swift
//  SOLID-DB
//
//  Created by admin on 5/21/20.
//  Copyright © 2020 PL. All rights reserved.
//

import Foundation

class DatabaseCreator {

    static func databaseCRUD(launchDatabaseParameter: LaunchDatabaseParameter) -> DatabaseServiceCRUDProtocol {

        switch launchDatabaseParameter {
        case .memory:
            return DatabaseMemory()
        case .userDefault:
            return DatabaseUserDefaults()
        case .realm:
            fatalError("not implemented")
        case .coreData:
            fatalError("not implemented")
        }
    }

}
