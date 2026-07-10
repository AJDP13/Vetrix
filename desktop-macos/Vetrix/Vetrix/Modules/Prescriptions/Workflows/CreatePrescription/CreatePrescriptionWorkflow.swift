//
//  CreatePrescriptionWorkflow.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 10/07/2026.
//

import SwiftUI
import VetrixCore

struct CreatePrescriptionWorkflow: View{
	@Bindable var vm: CreatePrescriptionViewModel
	
	var body: some View{
		//MARK: Header
		
		//MARK: Content
		switch(vm.currentStep){
			case .selectPet:
				SelectPetStep(vm: vm)
			default:
				Text("Other Step")
		}
		
		Spacer()
		
		//MARK: Footer
		VStack{
			ProgressView(value: vm.currentProgress)
				.progressViewStyle(.linear)
				.padding(.horizontal)
			
			HStack{
				Button("Cancel") {
					
				}
				
				Spacer()
				
				Text("Step \(vm.currentStep.index + 1) of \(CreatePrescriptionStep.totalSteps)")
					.foregroundStyle(.secondary)
				
				Spacer()
				
				Button("Back") {
					vm.previousStep()
				}
				.disabled(vm.currentStep.previous == nil)
				
				Button(vm.currentStep.next == nil ? "Create" : "Next") {
					vm.nextStep()
				}
				.keyboardShortcut(.defaultAction)
				.disabled(vm.canAdvanceToNextStep)
			}
			.padding()
			
		}
	}
}

#Preview {
	let baseUrl = URL(string: "http://127.0.0.1:3000")!
	let config = APIConfiguration(baseURL: baseUrl)
	let api = VetrixAPI(configuration: config)
	CreatePrescriptionWorkflow(vm: CreatePrescriptionViewModel(api:api ))
}
