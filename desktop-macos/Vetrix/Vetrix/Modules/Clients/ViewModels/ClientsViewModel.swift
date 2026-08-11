//
//  ClientsViewModel.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 08/07/2026.
//

import Foundation
import VetrixCore

@Observable
final class ClientsViewModel: PagedListViewModel<Client>{
	var clients: [Client] = []
	
	var selectedClients = Set<Client.ID>()
	
	var pageLimit: Int = 50
	
	var showCreateClientWizard: Bool = false
	var showClientDetailView: Bool = false
	
	private let api: VetrixAPI
	
	init(api: VetrixAPI){
		self.api = api
	}
	
	override func reload() async {
		//Load Page Limit Variable
		pagination.pageLimit = pageLimit
		
		isLoading = true
		errorMessage = nil
		
		defer{
			isLoading = false
		}
		
		do{
			let response = try await api.client.search(
				search: pagination.query,
				page: pagination.page,
				pageLimit: pagination.pageLimit,
			)
			
			clients = response.items
			pagination.update(response)
		}catch{
			api.errorManager.present(error)
		}
	}
	
	func archiveItem(id: UUID) async {
		do{
			let _ = try await api.client.archive(id: id)
			if let index = clients.firstIndex(where: { $0.id == id }) {
				let client = clients[index]
				clients[index] = client.withArchived(true)
			}
		}catch{
			api.errorManager.present(error)
		}
	}
}
