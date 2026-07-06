//
//  PaginatedResponse.swift
//  VetrixCore
//
//  Created by Arun Dutta-Plummer on 06/07/2026.
//

import Foundation

public struct PaginatedResponse<T: Decodable>: Decodable {
	let items: [T]
	let page: Int
	let pageSize: Int
	let total: Int
}
