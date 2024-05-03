//
//  CoreDataManagerMock.swift
//  GithubRepositorySearchTests
//
//  Created by takanoyuki on 2024/05/04.
//

import CoreData
@testable import GithubRepositorySearch

class CoreDataManagerMock: CoreDataManager {
    static let mockShared = CoreDataManagerMock()

    override func setDescription() {
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        persistentContainer.persistentStoreDescriptions = [description]
    }
}

