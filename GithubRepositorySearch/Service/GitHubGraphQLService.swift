//
//  GitHubGraphQLService.swift
//  GithubRepositorySearch
//
//  Created by takanoyuki on 2024/05/04.
//

import Foundation

protocol GitHubGraphQLService {
    func fetchRepositories(queryString: String, cursor: String?) async throws -> RepositorySearchResult
}
