//
//  RepositoryDetailView.swift
//  GithubRepositorySearch
//
//  Created by takanoyuki on 2024/05/04.
//

import SwiftUI

struct RepositoryDetailView: View {
    let repository: Repository

    var body: some View {
        VStack {
            Text("Repository Name: \(repository.name)")
            Text("Owner: \(repository.owner.login)")
            Text("Stars: \(repository.stargazers.totalCount)")
            Text("Forks: \(repository.forks.totalCount)")
        }
        .navigationBarTitle(Text(repository.name), displayMode: .inline)
    }
}

#Preview {
    RepositoryDetailView(repository: Repository(id: "1", name: "Repo1", owner: Owner(login: "owner1"), stargazers: Count(totalCount: 100), forks: Count(totalCount: 50)))
}
