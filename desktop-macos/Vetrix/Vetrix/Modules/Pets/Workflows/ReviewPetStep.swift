//
//  ReviewPetStep.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 14/08/2026.
//

import SwiftUI
import VetrixCore

struct ReviewPetStep: View{
	
	@Bindable var vm: CreatePetViewModel
	
	var body: some View{
		Text(vm.errorMessage)
			.foregroundStyle(.red)
		
		if(vm.pet.owner == nil){
			Text("Please return to the previous step and ensure all details have been filled in correctly")
		}else if vm.isLoading{
			ProgressView()
				.progressViewStyle(.circular)
			Text("Creating Pet...")
		}else if let success = vm.creationSuccess {
			Text("Successfully Created Pet")
			Text("ID: \(vm.createdPet!.id)")
				.font(.caption)
		}else{
			VStack{
				Text("Step 3: Pet Review")
					.font(.headline)
				
				HStack{
					Text("Pet: \(vm.pet.name)")
					Spacer()
					Text("Owner: \(vm.pet.owner!.fullName)")
				}
				
				Divider()
				
				Text("Pet Details")
					.font(.title2)
				HStack{
					Spacer()
					Text("Created By: \(vm.api.appSession.user!.fullName)")
				}
				
				Text("Please ensure all pet details are correct and then press create")
					.font(.caption)
			}
			.padding()
		}
	}
}

#Preview {
	let baseUrl = URL(string: "http://127.0.0.1:3000")!
	let config = APIConfiguration(baseURL: baseUrl)
	let api = VetrixAPI(configuration: config)
	ReviewStep(vm: CreatePrescriptionViewModel(api:api))
}
