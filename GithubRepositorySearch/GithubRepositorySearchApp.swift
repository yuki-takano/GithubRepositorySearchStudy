//
//  GithubRepositorySearchApp.swift
//  GithubRepositorySearch
//
//  Created by takanoyuki on 2024/05/03.
//

import SwiftUI

@main
struct GithubRepositorySearchApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            RepositoryListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
