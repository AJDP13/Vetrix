//
//  PickOwnerStep.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 14/08/2026.
//
import SwiftUI
import VetrixCore

struct SelectOwnerStep: View{
	
	@Bindable var vm: CreatePetViewModel
	
	var body: some View{
		//Step must allow user to search client database and select the right one - In future Utilise a ClientPicker / Generic EntityPicker
		
		VStack{
			Text("Step 1: Select Owner")
				.font(.headline)
			
			HStack{
				VStack{
					TextField("Search Clients", text: $vm.ownerQuery)
						.textFieldStyle(.roundedBorder)
					
					Text(vm.errorMessage)
						.foregroundStyle(.red)
						.font(.caption)
				}
				
				Button("Search"){
					Task{
						await vm.reloadClients()
					}
				}
				.disabled(vm.isLoading)
			}
			
			Spacer()
			
			Group{
				if vm.isLoading{
					ProgressView()
						.progressViewStyle(.circular)
					Text("Searching Client Database")
				}else if vm.clientResults.isEmpty {
					ZStack{
						Image(systemName: "sparkle.magnifyingglass")
							.resizable()
							.foregroundStyle(.red)
							.scaledToFit()
							.opacity(0.1)
						Text("No Clients found. Please refine Search criteria")
					}
				}else{
					Table(
						vm.clientResults,
						selection: $vm.selectedOwnerId,
					){
						TableColumn("ID"){ client in
							Text(client.id.uuidString.lowercased())
						}
						
						TableColumn("Full Name"){ client in
							Text(client.fullName)
						}
						
						TableColumn("Postcode") {client in
							Text(client.addressPostcode)
						}
					}
				}
			}
			
			Spacer()
		}
		.padding()
	}
}

#Preview {
	let baseUrl = URL(string: "http://127.0.0.1:3000")!
	let config = APIConfiguration(baseURL: baseUrl)
	let api = VetrixAPI(configuration: config)
	SelectPetStep(vm: CreatePrescriptionViewModel(api: api))
}
