//
//  Task.swift
//  WeSplit
//
//  Created by Aaron Ward on 2022-12-01.
//

import Foundation
import RealmSwift

class Task: Object, ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title = ""
    @Persisted var completed = false
}
