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

    func title() -> String {
        return "Memory Database"
    }

    weak var delegate: CRUD_CallbackProtocol?

    var data = [DataMemoryModel]()

    func addDelegate(_ ctrl: CRUD_CallbackProtocol) {
        delegate = ctrl
    }

    func create(dataViewModel: DataViewModel) {
        let dataMemoryModel = DataMemoryModel(viewModel: dataViewModel)
        data.append(dataMemoryModel)
        delegate?.refresh()
    }

    func remove(dataViewModel: DataViewModel) {
        let dataMemoryModel = DataMemoryModel(viewModel: dataViewModel)
        if let index = data.firstIndex(where: {$0.text == dataMemoryModel.text}) {
            data.remove(at: index)
        }
        delegate?.refresh()
    }

    func removeAll() {
        data = []
        delegate?.refresh()
    }

    func count() -> Int {
        return data.count
    }

    func getElement(index: Int) -> DataViewModel {
        let dataViewModel = DataViewModel(dataMemoryModel: data[index])
        return dataViewModel
    }
}
