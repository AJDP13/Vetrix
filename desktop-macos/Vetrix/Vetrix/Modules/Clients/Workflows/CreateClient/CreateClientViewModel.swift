//
//  CreatePrescriptionViewModel.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 10/07/2026.
//

import Foundation
import VetrixCore

enum CreateClientStep: Int, CaseIterable{
	case editDetails
	case review
	
	var next: CreateClientStep? {
		switch self {
			case .editDetails:
				return .review
			case .review:
				return nil
		}
	}
	
	var previous: CreateClientStep? {
		switch self{
			case.editDetails:
				return nil
			case .review:
				return .editDetails
		}
	}
	
	var index: Int {
		rawValue
	}
	
	var stepNumber: Int {
		rawValue + 1
	}

	static var totalSteps: Int {
		allCases.count
	}
}

@MainActor
@Observable
final class CreateClientViewModel{
	let api: VetrixAPI;
	
	//MARK: UI
	var errorMessage: String = ""
	var currentProgress: Float {
		return Float(currentStep.index) / Float(CreatePrescriptionStep.totalSteps-1)
	}
	var showDismissConfirmation: Bool = false
	
	//MARK: Client Details
	var client: DraftClient
	
	//MARK: Review Prescription
	var createdClient: Client?
	var creationSuccess: Bool?
	
	var currentStep: CreateClientStep = .editDetails
	
	var isLoading = false
	
	var canAdvanceToNextStep: Bool {
		switch(currentStep){
			case .editDetails:
				return true
			case .review:
				return true
			default:
				return true
		}
	}
	
	init(api: VetrixAPI){
		self.api = api
		self.client = DraftClient()
	}
	
	func previousStep() {
		guard currentStep.previous != nil else {return}
		self.errorMessage = ""
		currentStep = currentStep.previous!
	}
	
	func nextStep() {
		guard currentStep.next != nil else {return}
		self.errorMessage = ""
		currentStep = currentStep.next!
	}
	
	func createClient() async {
		self.errorMessage = ""
		
		isLoading = true
		
		defer{
			isLoading = false
		}
		
		do{
			createdClient = try await api.client.create()
			
			creationSuccess = true
		}catch let error as APIError{
			errorMessage = error.displayMessage
		} catch{
			errorMessage = error.localizedDescription
		}
	}
	
}
