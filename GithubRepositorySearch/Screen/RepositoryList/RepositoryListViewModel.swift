//
//  RepositoryListViewModel.swift
//  GithubRepositorySearch
//
//  Created by takanoyuki on 2024/05/04.
//

import Combine
import SwiftUI

class RepositoryListViewModel: ObservableObject {
    @Published var repositories: [Repository] = []
    @Published var searchHistories: [String] = []
    var searchText = ""
    @Published var isLoading = false
    @Published var pageInfo: PageInfo?

    private var cancellables: Set<AnyCancellable> = []
    private let repository: SearchRepository
    internal let coreDataManager: CoreDataManager

    init(repository: SearchRepository = SearchRepositoryImpl(url: Const.url, token: Const.token), coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.repository = repository
        self.coreDataManager = coreDataManager
        loadSearchHistory()
    }

    func fetchData(query: String, cursor: String? = nil) {
        guard !isLoading else { return }
        guard !query.isEmpty else {
            resetRepositories()
            loadSearchHistory()
            return
        }

        if cursor == nil {
            searchText = query
            self.repositories.removeAll()
            saveSearchQuery()
            loadSearchHistory()
        }

        self.isLoading = true

        Task {
            do {
                let result = try await repository.fetchRepositories(queryString: query, cursor: cursor)
                await MainActor.run {
                    self.repositories.append(contentsOf: result.data.search.edges.map { $0.node })
                    self.pageInfo = result.data.search.pageInfo
                    self.isLoading = false
                }
            } catch {
                print("Error fetching data: \(error)")
                await MainActor.run {
                    self.isLoading = false
                }
            }
        }
    }

    func loadMoreContentIfNeeded() {
        guard let pageInfo = pageInfo, pageInfo.hasNextPage else { return }
        fetchData(query: searchText, cursor: pageInfo.endCursor)
    }

    func resetRepositories() {
        repositories.removeAll()
    }

    func loadSearchHistory() {
        searchHistories = coreDataManager.fetchSearchHistory()
    }

    private func saveSearchQuery() {
        coreDataManager.saveSearchQuery(query: searchText)
    }
}

