//
//  ReviewStep.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 10/07/2026.
//

import SwiftUI
import VetrixCore

struct ReviewStep: View{
	
	@Bindable var vm: CreatePrescriptionViewModel
	
	var body: some View{
		Text(vm.errorMessage)
			.foregroundStyle(.red)
		
		if(vm.prescription.pet == nil){
			Text("Please return to the previous step and ensure all details have been filled in correctly")
		}else if vm.isLoading{
			ProgressView()
				.progressViewStyle(.circular)
			Text("Creating Prescription...")
		}else if let success = vm.creationSuccess {
			Text("Successfully Created Prescription")
			Text("ID: \(vm.createdPrescription!.id)")
				.font(.caption)
		}else{
			VStack{
				Text("Step 3: Prescription Review")
					.font(.headline)
				
				HStack{
					Text("Pet: \(vm.prescription.pet!.name)")
					Spacer()
					Text("Owner: \(vm.prescription.pet!.owner.fullName)")
				}
				
				Divider()
				
				Text("Prescription Details")
					.font(.title2)
				HStack{
					Text("State: \(vm.prescription.state)")
					Spacer()
					Text("Created By: \(vm.api.appSession.user!.fullName)")
				}
				
				HStack{
					Text("Prescribed At: \(vm.prescription.prescribedAt)")
					Spacer()
					Text("Expires At: \(vm.prescription.expiresAt)")
				}
				
				Text("Please ensure all prescription details are correct and then press create")
					.font(.caption)
			}
		}
	}
}

#Preview {
	let baseUrl = URL(string: "http://127.0.0.1:3000")!
	let config = APIConfiguration(baseURL: baseUrl)
	let api = VetrixAPI(configuration: config)
	ReviewStep(vm: CreatePrescriptionViewModel(api:api))
}
