//
//  CreatePrescriptionViewModel.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 10/07/2026.
//

import Foundation
import VetrixCore

enum CreatePrescriptionStep: Int, CaseIterable{
	case selectPet
	case editPrescription
	case review
	
	var next: CreatePrescriptionStep? {
		switch self {
			case .selectPet:
				return .editPrescription
			case .editPrescription:
				return .review
			case .review:
				return nil
		}
	}
	
	var previous: CreatePrescriptionStep? {
		switch self{
			case.selectPet:
				return nil
			case .editPrescription:
				return .selectPet
			case .review:
				return .editPrescription
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
final class CreatePrescriptionViewModel{
	let api: VetrixAPI;
	
	//MARK: UI
	var errorMessage: String = ""
	var currentProgress: Float {
		return Float(currentStep.index) / Float(CreatePrescriptionStep.totalSteps-1)
	}
	
	//MARK: SelectPet Step
	var petQuery: String = ""
	var petDOB: Date?
	var petResults: [Pet] = []
	
	//MARK: Prescription Details
	var prescription: DraftPrescription
	
	var currentStep: CreatePrescriptionStep = .selectPet
	
	var isLoading = false
	
	var canAdvanceToNextStep: Bool {
		switch(currentStep){
			case .selectPet:
				return prescription.pet != nil
			case .editPrescription:
				return prescription.expiresAt != nil && prescription.maxRepeats != nil && prescription.prescribedAt != nil
			default:
				return true
		}
	}
	
	init(api: VetrixAPI){
		self.api = api
		self.prescription = DraftPrescription()
	}
	
	func reloadPets() async {
		print("Attempting to load pets")
		guard !self.isLoading else {return}
		
		self.isLoading = true
		
		defer{
			self.isLoading = false
		}
		
		do{
			//Limit to top 25 pets since we do not need more than that for a specific search
			let pets = try await api.pet.getAll(searchQuery: self.petQuery, page: 1, pageLimit: 25)
			
			print("Received \(pets.items.count) pets")
			self.petResults = pets.items
		}catch let error as APIError{
			self.errorMessage = error.displayMessage
		}catch{
			self.errorMessage = error.localizedDescription
		}
		
		print("Finished loading pets")
	}
	
	func previousStep() {
		guard currentStep.previous != nil else {return}
		
		currentStep = currentStep.previous!
	}
	
	func nextStep() {
		guard currentStep.next != nil else {return}
		
		currentStep = currentStep.next!
	}
	
}
