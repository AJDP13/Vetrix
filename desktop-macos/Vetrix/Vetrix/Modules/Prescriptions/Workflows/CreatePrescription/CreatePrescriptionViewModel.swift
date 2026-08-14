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
final class CreatePrescriptionViewModel: Identifiable{
	let id = UUID() //For identifiable
	
	let api: VetrixAPI;
	
	//MARK: UI
	var errorMessage: String = ""
	var currentProgress: Float {
		return Float(currentStep.index) / Float(CreatePrescriptionStep.totalSteps-1)
	}
	var showDismissConfirmation: Bool = false
	
	//MARK: SelectPet Step
	var selectedPetId: Pet.ID?{
		didSet {
			prescription.pet = petResults.first { $0.id == selectedPetId }
		}
	}
	var petQuery: String = ""
	var petDOB: Date?
	var petResults: [Pet] = []
	var selectedPet: Pet? {
		guard let id = selectedPetId else { return nil }
		return petResults.first { $0.id == id }
	}
	
	//MARK: Prescription Details
	var prescription: DraftPrescription
	
	//MARK: Review Prescription
	var createdPrescription: Prescription?
	var creationSuccess: Bool?
	
	var currentStep: CreatePrescriptionStep = .selectPet
	
	var isLoading = false
	
	var canAdvanceToNextStep: Bool {
		switch(currentStep){
			case .selectPet:
				return selectedPetId != nil
			case .editPrescription:
				return prescription.expiresAt != nil && prescription.maxRepeats != nil && prescription.prescribedAt != nil
			default:
				return true
		}
	}
	
	init(
		api: VetrixAPI,
		pet: Pet? = nil,
		startingStep: CreatePrescriptionStep = .selectPet
	){
		self.api = api
		self.prescription = DraftPrescription()
		self.currentStep = startingStep
		
		if let pet{
			self.petResults = [pet]
			self.selectedPetId = pet.id
			self.prescription.pet = pet
		}
	}
	
	convenience init (
		api: VetrixAPI,
		pet: Pet
	){
		self.init(api: api, pet: pet, startingStep: .editPrescription)
	}
	
	func reloadPets() async {
		print("Attempting to load pets")
		guard !self.isLoading else {return}
		
		self.isLoading = true
		selectedPetId = nil
		
		defer{
			self.isLoading = false
		}
		
		do{
			//Limit to top 25 pets since we do not need more than that for a specific search
			let pets = try await api.pet.search(search: self.petQuery, page: 1, pageLimit: 25)
			
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
		self.errorMessage = ""
		currentStep = currentStep.previous!
	}
	
	func nextStep() {
		guard currentStep.next != nil else {return}
		self.errorMessage = ""
		currentStep = currentStep.next!
	}
	
	func createPrescription() async {
		prescription.pet = selectedPet
		
		self.errorMessage = ""
		guard selectedPet != nil && selectedPetId != nil else {
			errorMessage = "Ensure Pet details are properly selected"
			return
		}
		
		isLoading = true
		
		defer{
			isLoading = false
		}
		
		do{
			createdPrescription = try await api.prescription.create(pet_id: prescription.pet!.id, prescribed_at: prescription.prescribedAt, expires_at: prescription.expiresAt, max_repeats: prescription.maxRepeats, repeat_interval_day: prescription.repeatIntervalDays, prescribed_by: prescription.prescribedBy, prescribing_practice: prescription.prescribingPractice, notes: prescription.notes)
			
			creationSuccess = true
		}catch let error as APIError{
			errorMessage = error.displayMessage
		} catch{
			errorMessage = error.localizedDescription
		}
	}
	
}
