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
				TableColumn("Name"){ client in
					Text(client.fullName)
				}
				TableColumn("Email"){ client in
					Text(client.email)
				}
				TableColumn("Postcode"){ client in
					Text(client.addressPostcode)
				}
			}
			.contextMenu(forSelectionType: Client.self) { items in
				Button("Archive") {
					guard let client = items.first else { return }

					Task {
						await vm.archiveItem(id: client.id)
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
	}
}

#Preview {
	let baseUrl = URL(string: "http://127.0.0.1:3000")!
	let config = APIConfiguration(baseURL: baseUrl)
	let api = VetrixAPI(configuration: config)
	ClientsView(api: api)
}
