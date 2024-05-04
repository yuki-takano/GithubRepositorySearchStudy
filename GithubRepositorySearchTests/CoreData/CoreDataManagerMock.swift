//
//  CoreDataManagerMock.swift
//  GithubRepositorySearchTests
//
//  Created by takanoyuki on 2024/05/04.
//

import CoreData
@testable import GithubRepositorySearch

class CoreDataManagerMock: CoreDataManager {
    // テストではメモリ上にデータを保存して、アプリの挙動に影響を与えないようにする為の設定
    override func setDescription() {
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        persistentContainer.persistentStoreDescriptions = [description]
    }
}

extension CoreDataManager {
    static func getTestableCoreDataManager() -> CoreDataManagerMock {
        // テスト用に新しいインスタンスを都度生成
        return CoreDataManagerMock()
    }
}
