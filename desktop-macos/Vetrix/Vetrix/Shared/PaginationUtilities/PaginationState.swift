//
//  PaginationState.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 08/07/2026.
//

import Foundation
import VetrixCore

@Observable
public final class PaginationState{
	var page = 1
	var pageLimit = 50
	
	var total = 0
	var totalPages = 0
	
	var query = ""
	
	var hasNextPage: Bool{
		page < totalPages
	}
	
	var hasPreviousPage: Bool {
		page > 1
	}
	
	func update<T>(_ response: PaginatedResponse<T>){
		page = response.page
		pageLimit = response.pageLimit
		total = response.total
		totalPages = response.totalPages
	}
}
