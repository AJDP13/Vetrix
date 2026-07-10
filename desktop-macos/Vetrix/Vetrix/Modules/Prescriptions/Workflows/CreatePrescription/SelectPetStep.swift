//
//  SelectPetStep.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 10/07/2026.
//

import SwiftUI
import VetrixCore

struct SelectPetStep: View{
	
	@Bindable var vm: CreatePrescriptionViewModel
	
	var body: some View{
		//Step must allow user to search pet database and select the right one - In future Utilise a PetPicker / Generic EntityPicker
		
		VStack{
			Text("Step 1: Select Pet")
				.font(.headline)
			
			HStack{
				VStack{
					TextField("Search Pets", text: $vm.petQuery)
						.textFieldStyle(.roundedBorder)
					
					Text(vm.errorMessage)
						.foregroundStyle(.red)
						.font(.caption)
				}
				
				
				Spacer()
				
				Button("Search"){
					//Load pet results by using VM function
					Task{
						await vm.reloadPets()
					}
				}
				.disabled(vm.isLoading)
			}
			
			Spacer()
			
			Group{
				if vm.petResults.isEmpty {
					ZStack{
						Image(systemName: "sparkle.magnifyingglass")
							.resizable()
							.foregroundStyle(.red)
							.scaledToFit()
							.opacity(0.1)
						Text("No Pets found. Please refine Search criteria")
					}
				}else{
					Table(vm.petResults){
						TableColumn("ID"){ pet in
							Text(pet.id.uuidString.lowercased())
						}
						
						TableColumn("Name"){ pet in
							Text(pet.name)
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
