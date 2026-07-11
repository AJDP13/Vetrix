//
//  EditPrescriptionStep.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 10/07/2026.
//

import SwiftUI
import VetrixCore

struct EditClientStep: View{
	@Bindable var vm: CreateClientViewModel
	
	var body: some View{
		Text("Step 1: Edit Client Details")
			.font(.headline)
	}
}

#Preview {
	let baseUrl = URL(string: "http://127.0.0.1:3000")!
	let config = APIConfiguration(baseURL: baseUrl)
	let api = VetrixAPI(configuration: config)
	EditClientStep(vm: CreateClientViewModel(api:api))
}
