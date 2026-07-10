//
//  PrescriptionsView.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 08/07/2026.
//

import SwiftUI
import VetrixCore

struct PrescriptionsView: View{
	@State private var vm: PrescriptionsViewModel
	@State private var createPrescriptionVM: CreatePrescriptionViewModel
	
	init(api: VetrixAPI){
		self.vm = PrescriptionsViewModel(api: api)
		self.createPrescriptionVM = CreatePrescriptionViewModel(api: api)
	}
	
	var body: some View{
		//Insert paginated list of Prescriptions
		PagedView(
			pagination: vm.pagination,
			isLoading: vm.isLoading,
			next:{try? await vm.nextPage()},
			previous: {try? await vm.previousPage()},
		){
			Table(
				vm.prescriptions,
				selection: $vm.selectedPrescriptions
			){
				TableColumn("ID"){ prescription in
					Text(prescription.id.uuidString.lowercased())
				}
				TableColumn("Pet"){ prescription in
					Text(prescription.pet.name)
				}
				TableColumn("Owner"){ prescription in
					Text(prescription.pet.owner.fullName)
				}
				TableColumn("Prescribed On"){ prescription in
					Text(prescription.prescribedAt, format: .dateTime.day().month().year())
				}
				TableColumn("Prescriber"){ prescription in
					Text(prescription.prescribedBy)
				}
				TableColumn("Expiry"){ prescription in
					Text(prescription.expiresAt, format: .dateTime.day().month().year())
				}
				TableColumn("Max Repeats"){ prescription in
					Text("\(prescription.maxRepeats)")
				}
				TableColumn("Last Edited"){ prescription in
					Text(prescription.updatedAt, format: .dateTime.day().month().year())
				}
			}
		}
		.task{
			await vm.reload()
		}
		.toolbar{
			ToolbarItem(placement: .primaryAction){
				Button{
					vm.showCreatePrescriptionWizard.toggle()
				} label: {
					Image(systemName: "plus")
				}
				.help("Create Prescription")
			}
		}
		.sheet(isPresented: $vm.showCreatePrescriptionWizard){
			CreatePrescriptionWorkflow(vm: createPrescriptionVM)
				.frame(minWidth: 700, minHeight: 500)
		}
	}
}

#Preview {
	let baseUrl = URL(string: "http://127.0.0.1:3000")!
	let config = APIConfiguration(baseURL: baseUrl)
	let api = VetrixAPI(configuration: config)
	PrescriptionsView(api: api)
}
