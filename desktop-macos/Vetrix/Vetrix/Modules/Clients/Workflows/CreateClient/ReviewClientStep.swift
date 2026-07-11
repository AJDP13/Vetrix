//
//  ReviewStep.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 10/07/2026.
//

import SwiftUI
import VetrixCore

struct ReviewClientStep: View{
	
	@Bindable var vm: CreateClientViewModel
	
	var body: some View{
		Text(vm.errorMessage)
			.foregroundStyle(.red)
		
		if(vm.client == nil){
			Text("Please return to the previous step and ensure all details have been filled in correctly")
		}else if vm.isLoading{
			ProgressView()
				.progressViewStyle(.circular)
			Text("Creating Client Record...")
		}else if let success = vm.creationSuccess {
			Text("Successfully Created Client")
			Text("ID: \(vm.createdClient!.id)")
				.font(.caption)
		}else{
			VStack{
				Text("Step 3: Client Review")
					.font(.headline)
				
				HStack{
					Text("Name: \(vm.client.firstName) \(vm.client.lastName)")
					Spacer()
					Text("Email: \(vm.client.email)")
				}
				
				Text("Please ensure all client details are correct and then press create")
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
	ReviewClientStep(vm: CreateClientViewModel(api:api))
}
