//
//  SearchRepositoryImpl.swift
//  GithubRepositorySearch
//
//  Created by takanoyuki on 2024/05/04.
//

import Foundation

class SearchRepositoryImpl: SearchRepository {
    private let url: URL
    private let token: String
    init(url: URL, token: String) {
        self.url = url
        self.token = token
    }

    func fetchRepositories(queryString: String, cursor: String? = nil) async throws -> RepositorySearchResult {
        let service = GitHubGraphQLServiceImpl(url: url, token: token)
        do {
            return try await service.fetchRepositories(queryString: queryString, cursor: cursor)
        } catch {
            throw error
        }
    }
}
