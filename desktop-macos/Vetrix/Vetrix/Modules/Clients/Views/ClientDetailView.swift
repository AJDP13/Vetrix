//
//  PrescriptionDetailView.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 08/07/2026.
//

import SwiftUI
import VetrixCore

struct ClientDetailView: View{
	@Environment(\.dismiss) private var dismiss
	@State var vm: ClientDetailViewModel
	
	let onSaved: (Client) -> Void
	
	init(_ clientId: UUID, api: VetrixAPI, onSaved: @escaping (Client) -> Void){
		self._vm = State(initialValue: ClientDetailViewModel(
			clientId,
			api: api
		))
		self.onSaved = onSaved
	}
	
	var body: some View{
		Group{
			if vm.isLoading{
				ProgressView("Loading...")
			}else if vm.client != nil {
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
							dismiss() //Still dismiss if nil is returned so any errors are shown
							if let client = await vm.saveChanges() {
								onSaved(client)
							}
						}
					}
				}
				.formStyle(.grouped)
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
	ClientDetailView(Client.preview.id, api: api){ _ in
			
	}
}
