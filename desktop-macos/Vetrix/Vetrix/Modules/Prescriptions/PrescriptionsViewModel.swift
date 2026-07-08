//
//  PrescriptionsViewModel.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 08/07/2026.
//

import Foundation
import VetrixCore

@Observable
final class PrescriptionsViewModel: PagedListViewModel<Prescription>{
	var prescriptions: [Prescription] = []
	
	var selectedPrescriptions = Set<Prescription.ID>()
	
	private let api: VetrixAPI
	
	init(api: VetrixAPI){
		self.api = api
	}
	
	override func reload() async {
		guard !pagination.isLoading else {return}
		
		isLoading = true
		errorMessage = nil
		
		defer{
			isLoading = false
		}
		
		do{
			let response = try await api.prescription.getAll(
				page: pagination.page,
				pageLimit: pagination.pageLimit
			)
			
			prescriptions = response.items
			pagination.update(response)
		}catch{
			api.errorManager.present(error)
		}
	}
}
