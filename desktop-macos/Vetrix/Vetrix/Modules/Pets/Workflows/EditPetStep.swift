//
//  EditPetStep.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 14/08/2026.
//

import SwiftUI
import VetrixCore

struct EditPetStep: View{
	@Bindable var vm: CreatePetViewModel
	
	var body: some View{
		Text("Step 2: Edit Pet Details")
			.font(.headline)
		
		Form{
			TextField("Name", text: $vm.pet.name)
			DatePicker("Date of Birth", selection: $vm.pet.dob)
		}
	}
}

#Preview {
	let baseUrl = URL(string: "http://127.0.0.1:3000")!
	let config = APIConfiguration(baseURL: baseUrl)
	let api = VetrixAPI(configuration: config)
	EditClientStep(vm: CreateClientViewModel(api:api))
}
