//
//  SearchRepositoryMock.swift
//  GithubRepositorySearchTests
//
//  Created by takanoyuki on 2024/05/04.
//

import Foundation
@testable import GithubRepositorySearch

class SearchRepositoryMock: SearchRepository {
    var serviceMock: GitHubGraphQLServiceMock
    init(jsonFileName: String, shouldReturnSuccess: Bool) {
        self.serviceMock = GitHubGraphQLServiceMock(jsonFileName: jsonFileName, shouldReturnSuccess: shouldReturnSuccess)
    }

    func fetchRepositories(queryString: String, cursor: String? = nil) async throws -> RepositorySearchResult {
        return try await serviceMock.fetchRepositories(queryString: queryString, cursor: cursor)
    }

    func updateJSONFileName(newFileName: String) {
        serviceMock.jsonFileName = newFileName
    }

    func updateShouldReturnSuccess(flag: Bool) {
        serviceMock.shouldReturnSuccess = flag
    }
}
