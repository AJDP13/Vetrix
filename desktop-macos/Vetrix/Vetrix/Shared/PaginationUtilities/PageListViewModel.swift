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
	let pagination = PaginationState()
	
	var items: [T] = []
	
	var isLoading = false
	var errorMessage: String?
	
	func reload() async throws {
		fatalError("Override")
	}
	
	func nextPage() async throws {
		guard pagination.hasNextPage else {return}
		
		pagination.page += 1
		
		try await reload()
	}
	
	func previousPage() async throws {
		guard pagination.hasPreviousPage else {return}
		
		pagination.page -= 1
		
		try await reload()
	}
}
