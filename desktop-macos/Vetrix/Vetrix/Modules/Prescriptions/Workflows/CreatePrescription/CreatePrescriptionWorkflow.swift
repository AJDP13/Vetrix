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
	@Environment(\.dismiss) private var dismiss

	
	var body: some View{
		//MARK: Header
		VStack{
			Text("Create Prescription Wizard")
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
			
			
			
//			HStack{
//				Text("Selected Pet: \(vm.selectedPet != nil ? vm.selectedPet!.name : "None")")
//					.font(.caption)
//				
//				Spacer()
//				
//				Text("Owner: \(vm.selectedPet != nil ? vm.selectedPet!.owner.fullName : "N/A")")
//			}
			
			Divider()
		}
		.padding(.top)
		
		//MARK: Content
		switch(vm.currentStep){
			case .selectPet:
				SelectPetStep(vm: vm)
			case .editPrescription:
				EditPrescriptionStep(vm: vm)
			case .review:
				ReviewStep(vm: vm)
		}
		
		Spacer()
		
		//MARK: Footer
		VStack{
			ProgressView(value: vm.currentProgress)
				.progressViewStyle(.linear)
				.padding(.horizontal)
			
			HStack{
				Button("Cancel") {
					vm.showDismissConfirmation.toggle()
				}
				
				Spacer()
				
				Text("Step \(vm.currentStep.index + 1) of \(CreatePrescriptionStep.totalSteps)")
					.foregroundStyle(.secondary)
				
				Spacer()
				
				Button("Back") {
					vm.previousStep()
				}
				.disabled(vm.currentStep.previous == nil || vm.isLoading)
				
				Button(vm.currentStep.next == nil ? "Create" : "Next") {
					if vm.currentStep.next == nil {
						Task {
							await vm.createPrescription()
						}
					} else {
						vm.nextStep()
					}
				}
				.keyboardShortcut(.defaultAction)
				.disabled(!vm.canAdvanceToNextStep || vm.isLoading)
			}
			.padding()
			
		}
		.confirmationDialog(
			"Discard this prescription?",
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
	CreatePrescriptionWorkflow(vm: CreatePrescriptionViewModel(api:api ))
}
