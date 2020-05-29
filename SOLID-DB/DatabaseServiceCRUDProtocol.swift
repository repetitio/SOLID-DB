//
//  DatabaseCRUDProtocol.swift
//  SOLID-DB
//
//  Created by admin on 5/21/20.
//  Copyright © 2020 PL. All rights reserved.
//

import Foundation

protocol DatabaseServiceCRUDProtocol {
    func addDelegate(_ ctrl: CRUD_CallbackProtocol)
    func create(element: DatabaseViewModel)
    func count() -> Int
    func getElement(index: Int) -> DatabaseViewModel
    func title() -> String
}
