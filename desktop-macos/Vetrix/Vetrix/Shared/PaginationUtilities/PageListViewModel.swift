//
//  PageListViewModel.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 08/07/2026.
//

import Foundation
import VetrixCore

@Observable
class PagedListViewModel<T>{
	let pagination: PaginationState
	
	init(_ pagination: PaginationState = PaginationState()){
		self.pagination = pagination
	}
	
	var items: [T] = []
	
	var isLoading = false
	var errorMessage: String?
	
	func reload() async throws {
		fatalError("Override")
	}
	
	private func load(page: Int) async throws {
		guard !isLoading else {return}
		try await reload()
	}
	
	func nextPage() async throws {
		guard pagination.hasNextPage else {return}
		
		try await self.load(page: self.pagination.page+1)
		pagination.page += 1
	}
	
	func previousPage() async throws {
		guard pagination.hasPreviousPage else {return}
		
		try await self.load(page: self.pagination.page-1)
		pagination.page -= 1
	}
}
