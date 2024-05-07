//
//  RepositoryModel.swift
//  GithubRepositorySearch
//
//  Created by takanoyuki on 2024/05/04.
//

import Foundation

struct RepositorySearchResult: Decodable {
    let data: DataContainer
}

struct DataContainer: Decodable {
    let search: SearchResults
}

struct SearchResults: Decodable {
    let pageInfo: PageInfo
    let edges: [Edge]
}

struct PageInfo: Decodable {
    let endCursor: String?
    let hasNextPage: Bool
}

struct Edge: Decodable {
    let node: Repository
}

struct Repository: Identifiable, Decodable {
    var id: String
    var name: String
    var owner: Owner
    var stargazers: Count
    var forks: Count
    var watchers: Count
}

struct Owner: Decodable {
    let login: String
}

struct Count: Decodable {
    let totalCount: Int
}
