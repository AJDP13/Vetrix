//
//  ServerService.swift
//  VetrixCore
//
//  Created by Arun Dutta-Plummer on 13/08/2026.
//

import Foundation

@Observable
public final class ServerService {
	public private(set) var servers: [Server]
	
	public var selectedServerID: UUID? {
		didSet{
			save()
		}
	}
	
	public var selectedServer: Server?{
		servers.first{
			$0.id == selectedServerID
		}
	}
	
	private let defaults: UserDefaults
	
	private enum Keys{
		static let servers = "vetrix.servers"
		static let selectedServerID = "vetrix.selectedServierID"
	}
	
	public init(defaults: UserDefaults = .standard, defaultServers: [Server] = [
		Server("Local Development Server", URL(string: "http://98.0.8.1:3000")!),
		Server("Local Development Server 2", URL(string: "http://127.0.0.1:3000")!)
	]){
		self.servers = defaultServers
		self.defaults = defaults
		self.selectedServerID = self.servers.first?.id
		
		load()
	}
	
	public func add(_ server: Server){
		servers.append(server)
		save()
	}
	
	public func remove(_ server: Server){
		servers.removeAll{$0.id == server.id}
		
		if selectedServerID == server.id {
			selectedServerID = nil
		}
		
		save()
	}
	
	public func select(_ server: Server){
		guard servers.contains(where: {$0.id == server.id}) else {
			return
		}
		
		selectedServerID = server.id
	}
	
	private func load(){
		if let data = defaults.data(forKey: Keys.servers){
			servers = (try? JSONDecoder().decode(
				[Server].self,
				from: data
			)) ?? []
		}
		
		selectedServerID = defaults
			.string(forKey: Keys.selectedServerID)
			.flatMap(UUID.init)
	}
	
	private func save(){
		if let data = try? JSONEncoder().encode(servers){
			defaults.set(data, forKey: Keys.servers)
		}
		
		defaults.set(
			selectedServerID?.uuidString,
			forKey: Keys.selectedServerID
		)
	}

	public func ping(_ server: Server) async -> Bool {
		print("PINGING SERVER NOW")
		
		guard let url = URL(string: "/health", relativeTo: server.url) else {return false}
		
		var request = URLRequest(url: url)
		request.httpMethod = "HEAD"
		request.timeoutInterval = 5
		
		guard let index = servers.firstIndex(where: { $0.id == server.id }) else {return false}

		
		do{

			servers[index].last_ping = Date.now
			
			let (_, response) = try await URLSession.shared.data(for: request)
			
			guard let response = response as? HTTPURLResponse else {
				return false
			}
			
			if (200...299).contains(response.statusCode){
				servers[index].last_ping_success = Date.now
				return true
			}else{
				return false
			}
		}catch{
			return false
		}
	}
}
