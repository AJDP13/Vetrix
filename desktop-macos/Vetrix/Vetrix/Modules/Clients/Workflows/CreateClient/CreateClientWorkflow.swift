//
//  CreateClientWorkflow.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 11/07/2026.
//

import SwiftUI
import VetrixCore

struct CreateClientWorkflow: View{
	@Bindable var vm: CreateClientViewModel
	@Environment(\.dismiss) private var dismiss

	
	var body: some View{
		//MARK: Header
		VStack{
			Text("Create Client Wizard")
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
		Group{
			switch(vm.currentStep){
				case .editDetails:
					EditClientStep(vm: vm)
				case .review:
					ReviewClientStep(vm: vm)
			}
		}.padding()
		
		Spacer()
		
		//MARK: Footer
		VStack{
			ProgressView(value: vm.currentProgress)
				.progressViewStyle(.linear)
				.padding(.horizontal)
				.foregroundStyle(
					vm.currentProgress == 1 && (vm.createdClient != nil) ? .green : .blue
				)
			
			if vm.createdClient != nil{
				Button("Done"){
					dismiss()
				}
			}else{
				HStack{
					Button("Cancel") {
						vm.showDismissConfirmation.toggle()
					}
					
					Spacer()
					
					Text("Step \(vm.currentStep.index + 1) of \(CreateClientStep.totalSteps)")
						.foregroundStyle(.secondary)
					
					Spacer()
					
					Button("Back") {
						vm.previousStep()
					}
					.disabled(vm.currentStep.previous == nil || vm.isLoading)
					
					Button(vm.currentStep.next == nil ? "Create" : "Next") {
						if vm.currentStep.next == nil {
							Task {
								await vm.createClient()
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
			
		}
		.confirmationDialog(
			"Discard this client?",
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
	CreateClientWorkflow(vm: CreateClientViewModel(api:api ))
}
