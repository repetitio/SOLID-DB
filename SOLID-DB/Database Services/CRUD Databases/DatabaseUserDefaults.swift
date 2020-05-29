//
//  DatabaseUserDefaults.swift
//  SOLID-DB
//
//  Created by admin on 5/29/20.
//  Copyright © 2020 PL. All rights reserved.
//

import Foundation

class DatabaseUserDefaults: DatabaseServiceCRUDProtocol {

    func title() -> String {
        return "User Defaults Database"
    }

    weak var delegate: DatabaseTableviewProtocol?
    var data: [String]

    init() {
        let keysAllList = UserDefaults.standard.dictionaryRepresentation().keys
        let keysAllArray = keysAllList.map { String( $0 ) }
        let length = UUID().description.lengthOfBytes(using: .ascii)
        self.data = keysAllArray.filter { $0.lengthOfBytes(using: .ascii) == length }
    }

    func keyForDate(key: String) -> String {
        return "ForDate_" + key
    }

    func addDelegate(_ ctrl: DatabaseTableviewProtocol) {
        delegate = ctrl
    }

    func create(dataViewModel: DataViewModel) {
        let dataUserDefaultModel = DataUserDefaultModel(dataViewModel: dataViewModel)
        let key =  dataViewModel.uuid.description
        UserDefaults.standard.set(dataUserDefaultModel.text, forKey: key)
        UserDefaults.standard.set(dataUserDefaultModel.date, forKey: keyForDate(key: key))
        data.append(key)
        delegate?.refresh()
    }

    func remove(dataViewModel: DataViewModel) {
        let dataUserDefaultModel = DataUserDefaultModel(dataViewModel: dataViewModel)
        let key = dataUserDefaultModel.uuid.description
        if let index = data.firstIndex(where: {$0 == key}) {
            data.remove(at: index)
        }
        UserDefaults.standard.removeObject(forKey: key)
        delegate?.refresh()
    }

    func removeAll() {
        for key in data {
            UserDefaults.standard.removeObject(forKey: key)
            UserDefaults.standard.removeObject(forKey: keyForDate(key: key))
        }
        data = []
        delegate?.refresh()
    }

    func count() -> Int {
        return data.count
    }

    func getElement(index: Int) -> DataViewModel {
        let key = data[index]
        guard
            let uuid = UUID(uuidString: key),
            let text = UserDefaults.standard.string(forKey: key),
            let date = UserDefaults.standard.object(forKey: keyForDate(key: key)) as? Date
            else {
                fatalError("Database not synchronized")
        }
        let dataViewModel = DataViewModel(text: text, uuid: uuid, date: date)
        return dataViewModel
    }

    func synchronize() {
        UserDefaults.standard.synchronize()
    }
}
