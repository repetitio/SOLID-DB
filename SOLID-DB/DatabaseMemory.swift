//
//  DatabaseMemory.swift
//  SOLID-DB
//
//  Created by admin on 5/28/20.
//  Copyright © 2020 PL. All rights reserved.
//

import Foundation

protocol CRUD_CallbackProtocol: class {
    func refresh()
}

class DatabaseMemory: DatabaseServiceCRUDProtocol {

    weak var delegate: CRUD_CallbackProtocol?

    var data = [DatabaseViewModel]()

    func addDelegate(_ ctrl: CRUD_CallbackProtocol) {
        delegate = ctrl
    }

    func refresh() {
    }

    func title() -> String {
        return "Memory Database"
    }

    func create(element: DatabaseViewModel) {
        data.append(element)
        delegate?.refresh()
    }

    func count() -> Int {
        return data.count
    }

    func getElement(index: Int) -> DatabaseViewModel {
        return data[index]
    }
}
