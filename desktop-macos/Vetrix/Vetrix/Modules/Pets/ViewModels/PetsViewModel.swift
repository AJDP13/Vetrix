//
//  PetsViewModel.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 14/08/2026.
//

import Foundation
import VetrixCore

@Observable
final class PetsViewModel: PagedListViewModel<Pet>{
	var pets: [Pet] = []
	
	var selectedPets = Set<Pet.ID>()
	
	var pageLimit: Int = 50
	
	var showCreatePetWizard: Bool = false
	var showPetDetailView: Bool = false
	var showCreatePrescriptionWizard: Bool = false
	
	private let api: VetrixAPI
	
	init(api: VetrixAPI){
		self.api = api
	}
	
	override func reload() async {
		//Load Page Limit Variable
		pagination.pageLimit = pageLimit
		
		isLoading = true
		errorMessage = nil
		
		defer{
			isLoading = false
		}
		
		do{
			let response = try await api.pet.search(
				search: pagination.query,
				page: pagination.page,
				pageLimit: pagination.pageLimit,
			)
			
			pets = response.items
			pagination.update(response)
		}catch{
			api.errorManager.present(error)
		}
	}
	
	func archiveItem(id: UUID) async {
		do{
			let _ = try await api.pet.archive(id: id)
			if let index = pets.firstIndex(where: { $0.id == id }) {
				let pet = pets[index]
				pets[index] = pet.withArchived(true)
			}
		}catch{
			api.errorManager.present(error)
		}
	}
}
