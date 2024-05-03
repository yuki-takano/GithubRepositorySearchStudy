//
//  SearchHistory+CoreDataProperties.swift
//  GithubRepositorySearch
//
//  Created by takanoyuki on 2024/05/04.
//
//

import Foundation
import CoreData


extension SearchHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SearchHistory> {
        return NSFetchRequest<SearchHistory>(entityName: "SearchHistory")
    }

    @NSManaged public var query: String?
    @NSManaged public var date: Date?

}

extension SearchHistory : Identifiable {

}
