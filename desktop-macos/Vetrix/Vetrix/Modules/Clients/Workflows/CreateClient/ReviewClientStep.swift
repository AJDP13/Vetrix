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
		
		if vm.isLoading{
			ProgressView()
				.progressViewStyle(.circular)
			Text("Creating Client Record...")
		}else if let _ = vm.creationSuccess {
			Text("Successfully Created Client")
			Text("ID: \(vm.createdClient!.id)")
				.font(.caption)
		}else{
			VStack{
				Text("Step 2: Client Review")
					.font(.headline)
				
				Spacer()
				
				
				Circle()
					.fill(.blue.gradient)
					.frame(width: 44, height: 44)
					.overlay {
						Text("\(vm.client.firstName.prefix(1))\(vm.client.lastName.prefix(1))")
							.font(.headline.bold())
							.foregroundStyle(.white)
					}
				
				Text(vm.client.firstName + " " + vm.client.lastName)
				Text(vm.client.email)
				Text(vm.client.phone)
				
				Spacer()
				
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
