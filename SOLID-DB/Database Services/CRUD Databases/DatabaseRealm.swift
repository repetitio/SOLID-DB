//
//  DatabaseRealm.swift
//  SOLID-DB
//
//  Created by admin on 6/21/20.
//  Copyright © 2020 PL. All rights reserved.
//

import Foundation
import RealmSwift

class DataRealmModel: Object {
    @objc dynamic var text: String
    @objc dynamic var uuid: String
    @objc dynamic var date: Date

    override static func primaryKey() -> String? {
      return "uuid"
    }

    required init() {
        self.text = ""
        self.uuid = UUID().uuidString
        self.date = Date()
        super.init()
    }

    init(text: String, uuid: String, date: Date) {
        self.text = text
        self.uuid = uuid
        self.date = date
        super.init()
    }

    convenience init(dataViewModel: DataViewModel) {
        self.init(text: dataViewModel.text, uuid: dataViewModel.uuid.uuidString, date: dataViewModel.date)
    }

}

class DatabaseRealm: DatabaseServiceCRUDProtocol {

    weak var delegate: DatabaseTableviewProtocol?

    let realm: Realm

    init() {
        do {
            guard let configFile = Realm.Configuration.defaultConfiguration.fileURL else {
                fatalError()
            }
            let config = Realm.Configuration(schemaVersion: try schemaVersionAtURL(configFile) + 1)
            Realm.Configuration.defaultConfiguration = config

            self.realm = try Realm()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func create(dataViewModel: DataViewModel) {
        autoreleasepool {
            let dataRealmModel = DataRealmModel(dataViewModel: dataViewModel)
            do {
                try realm.write {
                    realm.add(dataRealmModel)
                    delegate?.refresh()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func remove(dataViewModel: DataViewModel) {
        autoreleasepool {
            let dataRealmModel = DataRealmModel(dataViewModel: dataViewModel)
            do {
                try realm.write {
                    if let object = realm.object(ofType: DataRealmModel.self, forPrimaryKey: dataRealmModel.uuid) {
                        realm.delete(object)
                        delegate?.refresh()
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func removeAll() {
        autoreleasepool {
            do {
                try realm.write {
                    realm.delete(realm.objects(DataRealmModel.self))
                    delegate?.refresh()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func getElement(index: Int) -> DataViewModel {
        let dataRealmModel = realm.objects(DataRealmModel.self)[index]
        return DataViewModel(dataRealmModel: dataRealmModel)
    }

    func addDelegate(_ ctrl: DatabaseTableviewProtocol) {
        delegate = ctrl
    }

    func count() -> Int {
        return realm.objects(DataRealmModel.self).count
    }

    func synchronize() {

    }

    func title() -> String {
        return "Realm Database"
    }

}
