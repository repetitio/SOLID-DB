//
//  DatabaseCRUDProtocol.swift
//  SOLID-DB
//
//  Created by admin on 5/21/20.
//  Copyright © 2020 PL. All rights reserved.
//

import Foundation

protocol DatabaseServiceCRUDProtocol {
    func create(dataViewModel: DataViewModel)
    func remove(dataViewModel: DataViewModel)
    func removeAll()

    //access:
    func getElement(index: Int) -> DataViewModel
    func addDelegate(_ ctrl: CRUD_CallbackProtocol)
    func count() -> Int
    func title() -> String
}
