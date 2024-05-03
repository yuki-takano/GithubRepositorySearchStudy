//
//  CoreDataManager.swift
//  GithubRepositorySearch
//
//  Created by takanoyuki on 2024/05/04.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer

    init() {
        persistentContainer = NSPersistentContainer(name: "SearchHistory")
        setDescription()
        persistentContainer.loadPersistentStores(completionHandler:  { _, error in
            if let error = error {
                            fatalError("Failed to load store: \(error)")
                        }
        })
    }

    func setDescription() {
        // アプリの挙動は空
        // UnitTestでCoreDataをメモリ上に記録するよう設定する為に定義する
        // UnitTestの結果をアプリのCoreDataに反映させないための措置
    }

    func saveSearchQuery(query: String) {
        let context = persistentContainer.viewContext
        let searchHistory = SearchHistory(context: context)
        searchHistory.query = query
        searchHistory.date = Date()
        do {
            try context.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }

    func fetchSearchHistory() -> [String] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<SearchHistory> = SearchHistory.fetchRequest()
        // 降順
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]

        do {
            let results = try context.fetch(fetchRequest)
            return results.map { $0.query ?? "" }
        } catch {
            print("Failed to fetch search history: \(error)")
            return []
        }
    }
}

