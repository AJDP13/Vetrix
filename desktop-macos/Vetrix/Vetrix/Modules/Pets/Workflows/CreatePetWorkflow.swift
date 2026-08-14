//
//  CreatePetWorkflow.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 14/08/2026.
//

import SwiftUI
import VetrixCore

struct CreatePetWorkflow: View{
	@Bindable var vm: CreatePetViewModel
	@Environment(\.dismiss) private var dismiss

	
	var body: some View{
		//MARK: Header
		VStack{
			Text("Create Pet Wizard")
				.font(.title)
			
			HStack{
				Text(vm.api.appSession.user?.fullName ?? "Full Name")
					.font(.caption)
					.foregroundStyle(.gray)
				
				Divider()
					.frame(height: 10)
				
				Text(vm.api.appSession.user?.username ?? "Username")
					.font(.caption)
					.foregroundStyle(.gray)
			}
			
			Divider()
		}
		.padding(.top)
		
		//MARK: Content
		switch(vm.currentStep){
			case .pickOwner:
				SelectOwnerStep(vm: vm)
			case .editDetails:
				EditPetStep(vm: vm)
			case .review:
				ReviewPetStep(vm: vm)
		}
		
		Spacer()
		
		//MARK: Footer
		VStack{
			ProgressView(value: vm.currentProgress)
				.progressViewStyle(.linear)
				.padding(.horizontal)
				.foregroundStyle(
					vm.currentProgress == 1 && (vm.createdPet != nil) ? .green : .blue
				)
			
			if vm.createdPet != nil{
				Button("Done"){
					dismiss()
				}
				.padding()
			}else{
				HStack{
					Button("Cancel") {
						vm.showDismissConfirmation.toggle()
					}
					
					Spacer()
					
					Text("Step \(vm.currentStep.index + 1) of \(CreatePetStep.totalSteps)")
						.foregroundStyle(.secondary)
					
					Spacer()
					
					Button("Back") {
						vm.previousStep()
					}
					.disabled(vm.currentStep.previous == nil || vm.isLoading)
					
					Button(vm.currentStep.next == nil ? "Create" : "Next") {
						if vm.currentStep.next == nil {
							Task {
								await vm.createPet()
							}
						} else {
							vm.nextStep()
						}
					}
					.disabled(!vm.canAdvanceToNextStep || vm.isLoading)
				}
				.padding()
			}
			
		}
		.confirmationDialog(
			"Discard this pet?",
			isPresented: $vm.showDismissConfirmation,
			titleVisibility: .visible
		) {
			Button("Discard Changes", role: .destructive) {
				dismiss()
			}

			Button("Continue Editing", role: .cancel) { }
		} message: {
			Text("Any unsaved changes will be lost.")
		}
	}
}

#Preview {
	let baseUrl = URL(string: "http://127.0.0.1:3000")!
	let config = APIConfiguration(baseURL: baseUrl)
	let api = VetrixAPI(configuration: config)
	CreatePetWorkflow(vm: CreatePetViewModel(api:api ))
}
