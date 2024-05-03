//
//  GitHubGraphQLServiceImpl.swift
//  GithubRepositorySearch
//
//  Created by takanoyuki on 2024/05/04.
//

import Foundation

class GitHubGraphQLServiceImpl: GitHubGraphQLService {
    private let url: URL
    private let token: String
    init(url: URL, token: String) {
        self.url = url
        self.token = token
    }


    func fetchRepositories(queryString: String, cursor: String? = nil) async throws -> RepositorySearchResult {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // GraphQLクエリ
        let graphqlQuery = """
        query SearchRepositories($queryString: String!, $afterCursor: String) {
          search(query: $queryString, type: REPOSITORY, first: 20, after: $afterCursor) {
            pageInfo {
              hasNextPage
              endCursor
            }
            edges {
              node {
                ... on Repository {
                  id
                  name
                  owner {
                    login
                  }
                  stargazers {
                    totalCount
                  }
                  forks {
                    totalCount
                  }
                }
              }
            }
          }
        }
        """

        // リクエストボディを作成
        var requestBody: [String: Any] = [
            "query": graphqlQuery,
            "variables": [
                "queryString": queryString
            ]
        ]

        // afterCursorがnilでない場合は、variablesに追加
        if let afterCursor = cursor {
            var variables = requestBody["variables"] as! [String: Any]
            variables["afterCursor"] = afterCursor
            requestBody["variables"] = variables
        }

        // JSONエンコーダーを使用してリクエストボディをJSONデータに変換
        let jsonData = try! JSONSerialization.data(withJSONObject: requestBody, options: [])
        request.httpBody = jsonData

        // リクスト
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        return try decoder.decode(RepositorySearchResult.self, from: data)
    }
}
