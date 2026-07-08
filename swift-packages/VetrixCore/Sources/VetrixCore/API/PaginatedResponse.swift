//
//  PaginatedResponse.swift
//  VetrixCore
//
//  Created by Arun Dutta-Plummer on 06/07/2026.
//

import Foundation

public struct PaginatedResponse<T: Decodable>: Decodable {
	public let items: [T]
	public let page: Int
	public let pageLimit: Int
	public let total: Int
	public let totalPages: Int
}
