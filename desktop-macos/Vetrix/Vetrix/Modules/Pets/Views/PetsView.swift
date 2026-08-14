//
//  PetsView.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 14/08/2026.
//
import SwiftUI
import VetrixCore

struct PetsView: View{
	private var api: VetrixAPI
	@State private var vm: PetsViewModel
	@State private var createPetVM: CreatePetViewModel
	@State private var createPrescriptionVM: CreatePrescriptionViewModel?
	@State private var selectedPetId: UUID?
	
	init(api: VetrixAPI){
		self.api = api
		self.vm = PetsViewModel(api: api)
		self.createPetVM = CreatePetViewModel(api: api)
	}
	
	var body: some View{
		//Insert paginated list of Pets
		PagedView(
			pagination: vm.pagination,
			isLoading: vm.isLoading,
			next:{try? await vm.nextPage()},
			previous: {try? await vm.previousPage()},
			search: {await vm.reload()}
		){
			Table(
				vm.pets,
				selection: $vm.selectedPets
			){
				TableColumn(""){pet in
					//Icon Column to show if user is archived
					if pet.archived{
						Image(systemName: "archivebox.fill")
							.foregroundStyle(.red)
							.help("Archived Pet")
							
					}
				}
				.width(min: 24, ideal: 28, max: 32)
				
				TableColumn("Name"){ pet in
					Text(pet.displayName)
				}
				
				TableColumn("Owner"){ pet in
					Text(pet.owner.fullName)
				}
				
				TableColumn("DOB"){ pet in
					Text(pet.dob.formatted(date: .abbreviated, time: .omitted))
				}
			}
			.contextMenu(forSelectionType: Pet.ID.self) { items in
				if let petId = items.first,
				   let pet = vm.pets.first(where: { $0.id == petId }) {
					
					if vm.selectedPets.count == 1 {
						Button("Open"){
							selectedPetId = petId
							vm.showPetDetailView.toggle()
						}
						
						Button("Create Prescription"){
							self.createPrescriptionVM = CreatePrescriptionViewModel(api: self.api, pet: pet)
							
							vm.showCreatePrescriptionWizard.toggle()
						}
						
						Divider()
						
						if pet.archived {
							Button("Restore") {
	//							Task {
	//								await vm.restoreItem(id: clientId)
	//							}
							}
						} else {
							Button("Archive") {
								Task {
									await vm.archiveItem(id: petId)
								}
							}
						}
					}
				}
			}
		}
		.task{
			await vm.reload()
		}
		.toolbar{
			ToolbarItem(placement: .primaryAction){
				Button{
					vm.showCreatePetWizard.toggle()
				} label: {
					Image(systemName: "plus")
				}
				.help("Create Pet")
			}
		}
		.sheet(isPresented: $vm.showCreatePetWizard){
			CreatePetWorkflow(vm: createPetVM)
				.frame(minWidth: 700, minHeight: 500)
				.interactiveDismissDisabled()
				.onDisappear{
					self.createPetVM = CreatePetViewModel(api: api)
				}
		}
		.sheet(isPresented: $vm.showPetDetailView) {
//			if let clientId = selectedClientId{
//				ClientDetailView(clientId, api: api) {updatedClient in
//					if let index = vm.clients.firstIndex(
//						where: { $0.id == updatedClient.id }
//					) {
//						vm.clients[index] = updatedClient
//					}
//				}
//			}else{
//				Text("Error: No client Selected")
//			}
		}
		.sheet(item: $createPrescriptionVM){ prescriptionVM in
			CreatePrescriptionWorkflow(vm: prescriptionVM)
				.frame(minWidth: 700, minHeight: 500)
				.interactiveDismissDisabled()
		}
	}
}

#Preview {
	let baseUrl = URL(string: "http://127.0.0.1:3000")!
	let config = APIConfiguration(baseURL: baseUrl)
	let api = VetrixAPI(configuration: config)
	ClientsView(api: api)
}
