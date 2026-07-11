//
//  MainView.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 26/06/2026.
//

import SwiftUI
import VetrixCore

struct MainView: View {
	let api: VetrixAPI
	
	@State private var vm: MainViewModel = MainViewModel()
	@State private var selection: Workspace? = .dashboard
	
	let navLinks: [WorkspaceItem] = [
		WorkspaceItem(id: .dashboard, title: "Dashboard", systemImage: "house", requiredPermissionId: nil),
		WorkspaceItem(id: .users, title: "Users", systemImage: "person.2", requiredPermissionId: .viewUsers),
		WorkspaceItem(id: .prescriptions, title: "Prescriptions", systemImage: "text.document", requiredPermissionId: .viewPrescriptions),
		WorkspaceItem(id: .clients, title: "Clients", systemImage: "user.fill", requiredPermissionId: .viewClients)
	]
	
    var body: some View {
		if api.appSession.user != nil {
			NavigationSplitView{
				List(navLinks, selection: $selection){ item in
					if item.requiredPermissionId == nil || api.appSession.user!.hasPermission(perm_id: item.requiredPermissionId!){
						Label(item.title, systemImage: item.systemImage)
							.tag(item.id)
					}
				}
				Spacer()
				Text("Welcome, \(api.appSession.user!.firstName)")
			} detail: {
				switch selection {
					case .dashboard:
						Text("DashboardView")
					case .users:
						UsersView(api: api)
					case .prescriptions:
						PrescriptionsView(api: api)
					case .clients:
						ClientsView(api:api)
					default:
						Text("OtherView")
				}
			}
		}else{
			VStack{
				Text("An unknown error has occurred. Please restart the application")
			}
		}
    }
}

#Preview {
	MainView(api: VetrixAPI(configuration: APIConfiguration(baseURL: URL(string: "http://127.0.0.1:3000")!)))
}
