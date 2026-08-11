//
//  ClientsView.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 08/07/2026.
//

import SwiftUI
import VetrixCore

struct ClientsView: View{
	private var api: VetrixAPI
	@State private var vm: ClientsViewModel
	@State private var createClientVM: CreateClientViewModel
	@State private var selectedClientId: UUID?
	
	init(api: VetrixAPI){
		self.api = api
		self.vm = ClientsViewModel(api: api)
		self.createClientVM = CreateClientViewModel(api: api)
	}
	
	var body: some View{
		//Insert paginated list of Clients
		PagedView(
			pagination: vm.pagination,
			isLoading: vm.isLoading,
			next:{try? await vm.nextPage()},
			previous: {try? await vm.previousPage()},
			search: {await vm.reload()}
		){
			Table(
				vm.clients,
				selection: $vm.selectedClients
			){
				TableColumn(""){client in
					//Icon Column to show if user is archived
					if client.archived{
						Image(systemName: "archivebox.fill")
							.foregroundStyle(.red)
							.help("Archived User")
							
					}
				}
				.width(min: 24, ideal: 28, max: 32)
				
				TableColumn("Full Name"){ client in
					Text(client.fullName)
				}
				
				TableColumn("Email"){ client in
					Text(client.email)
				}
				TableColumn("Postcode"){ client in
					Text(client.addressPostcode)
				}
			}
			.contextMenu(forSelectionType: Client.ID.self) { items in
				if let clientId = items.first,
				   let client = vm.clients.first(where: { $0.id == clientId }) {
					
					if vm.selectedClients.count == 1 {
						Button("Open"){
							selectedClientId = clientId
							vm.showClientDetailView.toggle()
						}
						
						Button("Create Pet"){
							
						}
						
						Divider()
						
						if client.archived {
							Button("Restore") {
	//							Task {
	//								await vm.restoreItem(id: clientId)
	//							}
							}
						} else {
							Button("Archive") {
								Task {
									await vm.archiveItem(id: clientId)
								}
							}
						}
					}
				}
			}
		}
		.task{
			await vm.reload()
		}
		.toolbar{
			ToolbarItem(placement: .primaryAction){
				Button{
					vm.showCreateClientWizard.toggle()
				} label: {
					Image(systemName: "plus")
				}
				.help("Create Client")
			}
		}
		.sheet(isPresented: $vm.showCreateClientWizard){
			CreateClientWorkflow(vm: createClientVM)
				.frame(minWidth: 700, minHeight: 500)
				.interactiveDismissDisabled()
				.onDisappear{
					self.createClientVM = CreateClientViewModel(api: api)
				}
		}
		.sheet(isPresented: $vm.showClientDetailView) {
			if let clientId = selectedClientId{
				ClientDetailView(clientId, api: api)
			}else{
				Text("Error: No client Selected")
			}
		}
	}
}

#Preview {
	let baseUrl = URL(string: "http://127.0.0.1:3000")!
	let config = APIConfiguration(baseURL: baseUrl)
	let api = VetrixAPI(configuration: config)
	ClientsView(api: api)
}
