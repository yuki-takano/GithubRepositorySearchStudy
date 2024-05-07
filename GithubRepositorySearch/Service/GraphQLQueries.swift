//
//  GraphQLQueries.swift
//  GithubRepositorySearch
//
//  Created by takanoyuki on 2024/05/04.
//

import Foundation

struct GraphQLQueries {
    static let searchRepositories = """
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
                  watchers {
                    totalCount
                  }
                }
              }
            }
          }
        }
        """
}
