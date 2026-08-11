//
//  PrescriptionDetailView.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 08/07/2026.
//

import SwiftUI
import VetrixCore

struct ClientDetailView: View{
	@State var vm: ClientDetailViewModel
	
	init(_ clientId: UUID, api: VetrixAPI){
		self._vm = State(initialValue: ClientDetailViewModel(
			clientId,
			api: api
		))
	}
	
	var body: some View{
		Group{
			if vm.client != nil {
				Form{
					TextField("First Name", text: $vm.firstName)
				}
			}else if vm.isLoading{
				ProgressView("Loading...")
			}
		}
		.task{
			await vm.reload()
		}
	}
}


#Preview {
	let baseUrl = URL(string: "http://127.0.0.1:3000")!
	let config = APIConfiguration(baseURL: baseUrl)
	let api = VetrixAPI(configuration: config)
	ClientDetailView(Client.preview.id, api: api)
}
