//
//  ServerService.swift
//  VetrixCore
//
//  Created by Arun Dutta-Plummer on 13/08/2026.
//

import Foundation

public final class ServerService {
	public private(set) var servers: [Server]
	
	public var selectedServer: Server?{
		didSet{
			save()
		}
	}
	
	private let storageKey = "vetrix.servers"
	private let selectedServerKey = "vetrix.selectedServer"
	
	public init(){
		self.servers = []
		self.selectedServer = nil
		
		load()
	}
	
	public func addServer(_ server: Server){
		servers.append(server)
		save()
	}
	
	public func removeServer(_ server: Server){
		servers.removeAll{$0.id == server.id}
		
		if selectedServer?.id == server.id {
			selectedServer = nil
		}
		
		save()
	}
	
	public func selectServer(_ server: Server){
		guard servers.contains(where: {$0.id == server.id}) else {
			return
		}
		
		selectedServer = server
	}
	
	private func load(){
		//Persistence
	}
	
	private func save(){
		//Persistence Save
	}
}
