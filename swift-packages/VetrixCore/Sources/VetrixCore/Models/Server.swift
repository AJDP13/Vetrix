//
//  Server.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 13/08/2026.
//

import Foundation

public struct Server: Hashable, Identifiable, Codable{
	public let id: UUID
	public var name: String
	public var url: URL
	public var alive: Bool
	public var last_ping_success: Date?
	public var last_ping: Date?
	
	public init(_ name: String, _ url: URL){
		self.id = UUID()
		self.name = name
		self.url = url
		self.alive = false
	}
}
