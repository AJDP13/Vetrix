//
//  Server.swift
//  VetrixCore
//
//  Created by Arun Dutta-Plummer on 13/08/2026.
//

import Foundation

public struct Server: Identifiable, Codable, Hashable {
	public let id: UUID
	public var name: String
	public var url: URL
	
	init(
		id: UUID = UUID(),
		name: String,
		url: URL
	){
		self.id = id
		self.name = name
		self.url = url
	}
}
