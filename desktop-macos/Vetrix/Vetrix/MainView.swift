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
		WorkspaceItem(id: .dashboard, title: "Dashboard", systemImage: "house"),
		WorkspaceItem(id: .users, title: "Users", systemImage: "person.2")
	]
	
    var body: some View {
		NavigationSplitView{
			List(navLinks, selection: $selection){ item in
				Label(item.title, systemImage: item.systemImage)
					.tag(item.id)
			}
		} detail: {
			switch selection {
				case .dashboard:
					Text("DashboardView")
				case .users:
					UsersView(api: api)
				default:
					Text("OtherView")
			}
		}
    }
}

#Preview {
	MainView(api: VetrixAPI(configuration: APIConfiguration(baseURL: URL(string: "http://127.0.0.1:3000")!)))
}
