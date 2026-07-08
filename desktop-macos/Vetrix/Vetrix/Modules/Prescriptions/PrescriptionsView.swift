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
	
	init(api: VetrixAPI){
		self.vm = PrescriptionsViewModel(api: api)
	}
	
	var body: some View{
		//Insert paginated list of Prescriptions
		PagedView(
			pagination: vm.pagination,
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
	}
}
