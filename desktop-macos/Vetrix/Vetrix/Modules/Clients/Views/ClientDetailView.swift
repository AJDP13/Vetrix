//
//  PrescriptionDetailView.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 08/07/2026.
//

import SwiftUI
import VetrixCore

struct ClientDetailView: View{
	@State var vm: ClientDetailViewModel
	
	init(_ clientId: UUID, api: VetrixAPI){
		self._vm = State(initialValue: ClientDetailViewModel(
			clientId,
			api: api
		))
	}
	
	var body: some View{
		Group{
			if vm.client != nil {
				Form{
					Section{
						TextField("First Name", text: $vm.firstName)
						TextField("Last Name", text: $vm.lastName)
						TextField("Email", text: $vm.email)
						TextField("Phone", text: $vm.phone)
					} header: {
						Text("Contact Information")
					}
					
					Section{
						TextField("Line 1", text: $vm.address1)
						TextField("Line 2", text: $vm.address2)
						TextField("Line 3", text: $vm.address3)
						TextField("City", text: $vm.addressCity)
						TextField("Postcode", text: $vm.addressPostcode)
					} header : {
						Text("Address Details")
					}
					
					Button("Update"){
						Task{
							await vm.saveChanges()
						}
					}
				}
				.formStyle(.grouped)
			}else if vm.isLoading{
				ProgressView("Loading...")
			}else{
				Text("No Client has been Selected")
			}
		}
		.task{
			await vm.reload()
		}
		.padding()
	}
}


#Preview {
	let baseUrl = URL(string: "http://127.0.0.1:3000")!
	let config = APIConfiguration(baseURL: baseUrl)
	let api = VetrixAPI(configuration: config)
	ClientDetailView(Client.preview.id, api: api)
}
