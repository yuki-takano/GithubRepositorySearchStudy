//
//  RepositoryListViewModelTests.swift
//  RepositoryListViewModelTests
//
//  Created by takanoyuki on 2024/05/03.
//

import XCTest

import CoreData
@testable import GithubRepositorySearch

class RepositoryListViewModelTests: XCTestCase {
    var viewModel: RepositoryListViewModel!
    var repositoryMock: SearchRepositoryMock!
    var coreDataManagerMock: CoreDataManagerMock!

    override func setUp() {
        super.setUp()
        coreDataManagerMock = CoreDataManagerMock.getTestableCoreDataManager()
        repositoryMock = SearchRepositoryMock(jsonFileName: "firstPage", shouldReturnSuccess: true)
        viewModel = RepositoryListViewModel(repository: repositoryMock, coreDataManager: coreDataManagerMock)
    }

    override func tearDown() {
        viewModel = nil
        repositoryMock = nil
        super.tearDown()
    }

    // リポジトリ初回検索
    func testFetchDataSuccessEmptyInitial() {
        let expectation = XCTestExpectation(description: "Fetch data completes and updates repositories")

        let query = "Swift"
        viewModel.fetchData(query: query)

        // XCTestExpectationを使用して、非同期処理が完了するのを待ちます。
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            XCTAssertFalse(self.viewModel.repositories.isEmpty, "Repositories should not be empty after successful fetch")
            let saveQueries = self.viewModel.coreDataManager.fetchSearchHistory()
            XCTAssertTrue(saveQueries.contains(query),  "The query should be saved in the search history.")
            XCTAssertTrue(self.viewModel.pageInfo!.hasNextPage, "There is still available for the API inquiry")
            XCTAssertTrue(!self.viewModel.isLoading, "isLoading should be false after fetchData")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }

    // リポジトリ初回失敗
    func testFetchDataFailure() {
        let expectation = XCTestExpectation(description: "Fetch data fails and repositories remain empty")

        // モックを設定して、失敗をシミュレートします。
        repositoryMock = SearchRepositoryMock(jsonFileName: "firstPage", shouldReturnSuccess: false)
        viewModel = RepositoryListViewModel(repository: repositoryMock)
        let query = "Swift"
        viewModel.fetchData(query: query)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            XCTAssertTrue(self.viewModel.repositories.isEmpty, "Repositories should be empty after fetch failure")
            let saveQueries = self.viewModel.coreDataManager.fetchSearchHistory()
            // 検索に失敗したした場合でも後から検索し直す為に検索履歴に保存する仕様にした
            XCTAssertTrue(saveQueries.contains(query),  "The query should be saved in the search history.")
            XCTAssertNil(self.viewModel.pageInfo, "The pageInfo should be nil")
            XCTAssertTrue(!self.viewModel.isLoading, "isLoading should be false after fetchData")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }

    // ページネーションでの追加読み込み成功
    func testLoadMoreContentIfNeededSuccess() {
        let expectation = XCTestExpectation(description: "Load more content successfully")

        // 初期データを設定(2ページ目のデータをAPIで返すよう設定)
        repositoryMock = SearchRepositoryMock(jsonFileName: "secondPage", shouldReturnSuccess: true)
        viewModel = RepositoryListViewModel(repository: repositoryMock, coreDataManager: coreDataManagerMock)
        viewModel.searchText = "Swift"
        viewModel.repositories = [Repository(id: "1", name: "Repo1", owner: Owner(login: "owner1"), stargazers: Count(totalCount: 100), forks: Count(totalCount: 50))]
        viewModel.pageInfo = PageInfo(endCursor: "Y3Vyc29yOjEw", hasNextPage: true)

        viewModel.loadMoreContentIfNeeded()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            XCTAssertTrue(self.viewModel.repositories.count > 1, "More repositories should be loaded on successful pagination")
            // APIリクエストは成功で、これ以上データが無いのでpageInfoはforce wrapする
            XCTAssertFalse(self.viewModel.pageInfo!.hasNextPage, "There is no further data available for the API inquiry")
            XCTAssertTrue(!self.viewModel.isLoading, "isLoading should be false after fetchData")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 4.0)
    }

    // ページネーションでの追加読み込み失敗
    func testLoadMoreContentIfNeededFailure() {
        let expectation = XCTestExpectation(description: "Load more content failure")

        // 初期データを設定(2ページ目のデータをAPIで返すよう設定)
        repositoryMock = SearchRepositoryMock(jsonFileName: "secondPage", shouldReturnSuccess: false)
        viewModel = RepositoryListViewModel(repository: repositoryMock, coreDataManager: coreDataManagerMock)
        viewModel.searchText = "Swift"
        viewModel.repositories = [Repository(id: "1", name: "Repo1", owner: Owner(login: "owner1"), stargazers: Count(totalCount: 100), forks: Count(totalCount: 50))]
        viewModel.pageInfo = PageInfo(endCursor: "Y3Vyc29yOjEw", hasNextPage: true)

        viewModel.loadMoreContentIfNeeded()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            XCTAssertTrue(self.viewModel.repositories.count == 1, "More repositories should be not loaded on failure pagination")
            // APIリクエストの初回は成功している想定の為、pageInfoはforce wrap、かつhasNextPageはtrueのまま
            XCTAssertTrue(self.viewModel.pageInfo!.hasNextPage, "There is still available for the API inquiry")
            XCTAssertTrue(!self.viewModel.isLoading, "isLoading should be false after fetchData")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 4.0)
    }

    // repositoriesのリセット処理のテスト
    func testResetRepositories() {
        viewModel.repositories = [Repository(id: "1", name: "Repo1", owner: Owner(login: "owner1"), stargazers: Count(totalCount: 100), forks: Count(totalCount: 50))]
        viewModel.resetRepositories()
        XCTAssertTrue(viewModel.repositories.isEmpty, "repositories should be empty after resetRepositories")

    }


}
