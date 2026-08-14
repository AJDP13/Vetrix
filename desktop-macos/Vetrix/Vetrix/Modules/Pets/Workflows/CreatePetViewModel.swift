//
//  CreatePetViewModel.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 14/08/2026.
//
import Foundation
import VetrixCore

enum CreatePetStep: Int, CaseIterable{
	case pickOwner
	case editDetails
	case review
	
	var next: CreatePetStep? {
		switch self {
			case .pickOwner:
				return .editDetails
			case .editDetails:
				return .review
			case .review:
				return nil
		}
	}
	
	var previous: CreatePetStep? {
		switch self{
			case .pickOwner:
				return nil
			case.editDetails:
				return .pickOwner
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
final class CreatePetViewModel{
	let api: VetrixAPI;
	
	//MARK: UI
	var errorMessage: String = ""
	var currentProgress: Float {
		return Float(currentStep.index) / Float(CreateClientStep.totalSteps-1)
	}
	var showDismissConfirmation: Bool = false
	
	//MARK: Pet Details
	var pet: DraftPet
	
	//MARK: Owner Details
	var owner: Client?
	var currentStep: CreatePetStep = .pickOwner
	
	//MARK: Select Owner
	var ownerQuery: String = ""
	var clientResults: [Client] = []
	var selectedOwnerId: Pet.ID?{
		didSet {
			pet.owner = clientResults.first { $0.id == selectedOwnerId }
		}
	}
	
	//MARK: Create Pet
	var createdPet: Pet?
	var creationSuccess: Bool?

	var isLoading = false
	
	var canAdvanceToNextStep: Bool {
		switch(currentStep){
			case .pickOwner:
				return true
			case .editDetails:
				return true
			case .review:
				return true
		}
	}
	
	init(api: VetrixAPI){
		self.api = api
		self.pet = DraftPet()
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
	
	func reloadClients() async {
		guard !self.isLoading else {return}
		
		self.isLoading = true
		self.selectedOwnerId = nil
		
		defer{
			self.isLoading = false
		}
		
		do{
			//Limit to top 25 pets since we do not need more than that for a specific search
			let clients = try await api.client.search(search: self.ownerQuery, page: 1, pageLimit: 25)
			
			self.clientResults = clients.items
		}catch let error as APIError{
			self.errorMessage = error.displayMessage
		}catch{
			self.errorMessage = error.localizedDescription
		}
	}
	
	func createPet() async {
		self.errorMessage = ""
		
		isLoading = true
		
		defer{
			isLoading = false
		}
		
		do{
			createdPet = try await api.pet.create(name: pet.name, date_of_birth: pet.dob, owner: pet.owner!)
			
			creationSuccess = true
		}catch let error as APIError{
			errorMessage = error.displayMessage
		} catch{
			errorMessage = error.localizedDescription
		}
	}
	
}
