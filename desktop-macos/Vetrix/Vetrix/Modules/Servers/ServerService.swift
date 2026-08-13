//
//  Server.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 13/08/2026.
//

import Foundation

public final class ServerService {
	public var servers: [Server] = []
	
	init(){
	}
	
	public func ping(_ index: Int) async throws -> Bool{
		do{
			var server: Server = servers[index]
			
			
		}catch{
			
		}
		return true
	}
}


public struct Server: Hashable, Identifiable, Codable{
	public let id: UUID
	public var url: String
	public var port: Int
	
	init(_ url: String, _ port: Int){
		self.id = UUID()
		self.url = url
		self.port = port
	}
}
