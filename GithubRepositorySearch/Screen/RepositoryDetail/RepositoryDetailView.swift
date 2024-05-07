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
        VStack(alignment: .leading) {
            Text("Name: \(repository.name)")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 16)

            VStack(alignment: .leading, spacing: 8) {
                Text("Owner: \(repository.owner.login)")
                    .font(.headline)
                Text("Stars: \(repository.stargazers.totalCount)")
                    .font(.headline)
                Text("Forks: \(repository.forks.totalCount)")
                    .font(.headline)
                Text("Watchers: \(repository.watchers.totalCount)")
                    .font(.headline)
            }
            .padding(.leading, 8)
        }
        .navigationBarTitle(Text("Repository Detail"), displayMode: .inline)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
    }
}

struct RepositoryDetailView_Preview: PreviewProvider {
    static var previews: some View {
        RepositoryDetailView(repository: Repository(id: "1", name: "Repo1", owner: Owner(login: "owner1"), stargazers: Count(totalCount: 100), forks: Count(totalCount: 50), watchers: Count(totalCount: 100)))
    }
}
