//
//  RepositoryListView.swift
//  GithubRepositorySearch
//
//  Created by takanoyuki on 2024/05/04.
//

import SwiftUI
import Combine

struct RepositoryListView: View {
    @StateObject private var viewModel = RepositoryListViewModel()
    @State private var searchText = ""
    @FocusState private var isTextFieldFocused: Bool

    var body: some View {
        NavigationView {
            ZStack {
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        isTextFieldFocused = false
                    }
                VStack {
                    HStack {
                        TextField("Search GitHub Repositories", text: $searchText)
                            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                            .cornerRadius(5)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black, lineWidth: 1))
                            .overlay(
                                HStack {
                                    Spacer()
                                    if !searchText.isEmpty {
                                        Button(action: {
                                            searchText = ""
                                            viewModel.resetRepositories()
                                            viewModel.loadSearchHistory()
                                        }) {
                                            Image(systemName: "multiply.circle.fill").foregroundColor(.gray)
                                        }.padding(.trailing, 8)
                                    }
                                }
                            )
                            .padding()
                            .focused($isTextFieldFocused)
                            .onSubmit {
                                isTextFieldFocused = false
                            }
                        Button(action: {
                            isTextFieldFocused = false
                            viewModel.fetchData(query: searchText)
                        }) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.blue)
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8))
                    }.padding(.horizontal, 8)

                    if !viewModel.repositories.isEmpty {
                        List(viewModel.repositories.indices, id: \.self) { index in
                            let repository = viewModel.repositories[index]
                            NavigationLink(destination: RepositoryDetailView(repository: repository)) {
                                RepositoryRow(repository: repository)
                            }
                            .onAppear {
                                if index >= viewModel.repositories.count - 3 {
                                    viewModel.loadMoreContentIfNeeded()
                                }
                            }
                        }
                        .gesture(DragGesture().onChanged({ _ in
                            isTextFieldFocused = false
                        }))
                    } else {
                        HStack {
                            Text("Search Histories")
                                .padding(.leading, 24)
                            Spacer()
                        }

                        List(viewModel.searchHistories.indices, id: \.self) { index in
                            Button(action: {
                                searchText = viewModel.searchHistories[index]
                                isTextFieldFocused = false
                                viewModel.fetchData(query: searchText)
                            }) {
                                QueryRow(query: viewModel.searchHistories[index])
                            }
                        }
                    }
                }

                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(2.0, anchor: .center)
                }
            }
            .navigationTitle("GitHub Repositories")
        }
    }
}

struct RepositoryRow: View {
    let repository: Repository

    var body: some View {
        VStack(alignment: .leading) {
            Text(repository.name).font(.headline)
            Text("Owner: \(repository.owner.login)").font(.subheadline)
            Text("Stars: \(repository.stargazers.totalCount)").font(.subheadline)
            Text("Forks: \(repository.forks.totalCount)").font(.subheadline)
        }.frame(height: 70)
    }
}

struct QueryRow: View {
    let query: String

    var body: some View {
        Text(query)
            .font(.headline)
            .frame(height: 20)
    }
}


struct RepositoryListView_Preview: PreviewProvider {
    static var previews: some View {
        RepositoryListView()
    }
}

