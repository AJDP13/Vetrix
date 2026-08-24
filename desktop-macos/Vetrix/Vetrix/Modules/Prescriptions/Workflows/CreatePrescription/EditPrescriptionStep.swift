//
//  EditPrescriptionStep.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 10/07/2026.
//

import SwiftUI
import VetrixCore

struct EditPrescriptionStep: View{
	@Bindable var vm: CreatePrescriptionViewModel
	
	var body: some View{
		Text("Step 2: Edit Prescription Details")
			.font(.headline)
		
		Group{
			
			if vm.selectedPet?.owner.archived ?? false {
				Text("Selected pet has an archived owner. Please un-archive the owner before creating new prescriptions")
					.foregroundStyle(.red)
			}else{
				Form{
					VStack{
						HStack{
							LabeledContent("Pet") {
								if let pet = vm.selectedPet,
								   let id = vm.selectedPetId {
									Text("\(pet.name) (\(id.uuidString.prefix(6)))")
								} else {
									Text("Not Selected")
										.foregroundStyle(.secondary)
								}
							}
							
							LabeledContent("Owner") {
								if let pet = vm.selectedPet{
									Text("\(pet.owner.fullName)")
								} else {
									Text("*UNKNOWN*")
										.foregroundStyle(.secondary)
								}
							}
						}
						
						//MARK: Counters
						
						HStack{
							Spacer()
							
							Stepper("Repeat Interval*: \(vm.prescription.repeatIntervalDays) Days", value: $vm.prescription.repeatIntervalDays)
								.padding(.trailing)
							
							Spacer()
							
							Stepper("Max Repeats*: \(vm.prescription.maxRepeats)", value: $vm.prescription.maxRepeats)
							
							Spacer()
						}
						
						//MARK: Dates
						HStack{
							DatePicker(
								"Prescribed Date*",
								selection: $vm.prescription.prescribedAt,
								displayedComponents: .date
							)
							
							DatePicker(
								"Expiry Date*",
								selection: $vm.prescription.expiresAt,
								displayedComponents: .date
							)
						}
						
						//MARK: Prescriber Info
						HStack{
							TextField("Prescribed By", text: $vm.prescription.prescribedBy)
							
							TextField("Prescribing Practice", text: $vm.prescription.prescribingPractice)
								
						}
						
						ZStack(alignment: .topLeading) {
							if vm.prescription.notes.isEmpty {
								Text("Enter prescription notes...")
									.foregroundStyle(.secondary)
									.padding(.horizontal, 8)
									.padding(.vertical, 8)
									.allowsHitTesting(false)
									.zIndex(1)
							}
							
							TextEditor(text: $vm.prescription.notes)
								.scrollContentBackground(.hidden)
								.background(.clear)
								.padding(.top, 10)
								.padding(.leading, 4)
						}
						.frame(height: 120)
						.overlay {
							RoundedRectangle(cornerRadius: 6)
								.stroke(.quaternary)
						}
					}.padding()
					
				}
			}
		}
	}
}

#Preview {
	let api: VetrixAPI = VetrixAPI(configuration: .preview)
	EditPrescriptionStep(vm: CreatePrescriptionViewModel(api:api))
}
