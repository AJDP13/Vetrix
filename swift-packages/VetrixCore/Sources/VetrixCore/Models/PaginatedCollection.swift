//
//  PaginatedCollection.swift
//  VetrixCore
//
//  Created by Arun Dutta-Plummer on 26/06/2026.
//

public final class PaginatedCollection<T> {
	public typealias FetchPage = (_ page: Int, _ pageLimit: Int) async throws -> PaginatedCollection<T>
	
	private let fetch: FetchPage
	
	public private(set) var items: [T] = []
	public private(set) var page = 1
	public private(set) var pageLimit = 0
	
	
	public init (fetch: @escaping FetchPage){
		self.fetch = fetch
	}
	
	public func refresh() async throws {
		let response = try await fetch(1, 50)
		items = response.items
		page = 1
		
	}
}
