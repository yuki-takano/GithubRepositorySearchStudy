//
//  GitHubGraphQLServiceMock.swift
//  GithubRepositorySearchTests
//
//  Created by takanoyuki on 2024/05/04.
//

import Foundation
@testable import GithubRepositorySearch

class GitHubGraphQLServiceMock: GitHubGraphQLService {
    var jsonFileName: String
    var shouldReturnSuccess: Bool

    init(jsonFileName: String, shouldReturnSuccess: Bool = true) {
        self.jsonFileName = jsonFileName
        self.shouldReturnSuccess = shouldReturnSuccess
    }

    func fetchRepositories(queryString: String, cursor: String?) async throws -> RepositorySearchResult {
        guard shouldReturnSuccess else {
            throw NSError(domain: "", code: -1)
        }
        let bundle = Bundle(for: type(of: self))
        print("Looking for resource in path: \(bundle.bundlePath)")
        guard let url = bundle.url(forResource: jsonFileName, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            throw NSError(domain: "FileNotFound", code: 404)
        }
        let decoder = JSONDecoder()
        return try decoder.decode(RepositorySearchResult.self, from: data)
    }
}
