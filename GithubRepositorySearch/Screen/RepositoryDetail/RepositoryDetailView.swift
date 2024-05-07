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
            HStack(alignment: .center) {
                Image(systemName: "book.fill")
                    .padding(.top, 20)
                    .frame(width: 30, height: 30, alignment: .center)
                Text("\(repository.name)")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 16)
            }
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Image(systemName: "person.fill")
                        .frame(width: 20)
                    Text("Owner: \(repository.owner.login)")
                        .font(.headline)
                }
                HStack {
                    Image(systemName: "star.fill")
                        .frame(width: 20)
                        .foregroundColor(.yellow)
                    Text("Stars: \(repository.stargazers.totalCount)")
                        .font(.headline)
                }
                HStack {
                    Image(systemName: "arrow.triangle.branch")
                        .frame(width: 20)
                    Text("Forks: \(repository.forks.totalCount)")
                        .font(.headline)
                }
                HStack {
                    Image(systemName: "eye")
                        .frame(width: 20)
                    Text("Watchers: \(repository.watchers.totalCount)")
                        .font(.headline)
                }
            }
            .padding(.leading, 16)
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
