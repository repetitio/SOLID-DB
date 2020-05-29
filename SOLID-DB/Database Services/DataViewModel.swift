//
//  DataViewModel.swift
//  SOLID-DB
//
//  Created by admin on 5/28/20.
//  Copyright © 2020 PL. All rights reserved.
//

import Foundation

struct DataViewModel {
    let text: String
    let uuid: UUID
    let date: Date

    init(text: String) {
        self.text = text
        self.uuid = UUID()
        self.date = Date()
    }

    init(text: String, uuid: UUID) {
        self.text = text
        self.uuid = uuid
        self.date = Date()
    }

    init(dataMemoryModel: DataMemoryModel) {
        self.init(text: dataMemoryModel.text)
    }

    init(dataUserDefaultModel: DataUserDefaultModel) {
        self.init(text: dataUserDefaultModel.text, uuid: dataUserDefaultModel.uuid)
    }
}

struct DataMemoryModel {
    let text: String

    init(viewModel: DataViewModel) {
        self.text = viewModel.text
    }
}

struct DataUserDefaultModel {
    let text: String
    let uuid: UUID

    init(viewModel: DataViewModel) {
        self.text = viewModel.text
        self.uuid = viewModel.uuid
    }

}
