//
//  UsersView.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 26/06/2026.
//

import SwiftUI
import VetrixCore

struct UsersView: View {
	@State var vm: UsersViewModel
	private var createVm: CreateUserViewModel
	
	@State private var showCreateUser = false
	
	init(api: VetrixAPI){
		_vm = State(initialValue: UsersViewModel(api: api))
		createVm = CreateUserViewModel(api: api)
	}
	
    var body: some View {
		Group{
			if vm.isLoading {
				VStack{
					ProgressView()
					Text("Loading Users")
				}
			}else{
				NavigationStack{
					List(vm.filteredUsers){ user in
						NavigationLink{
							UserDetailView(user: user)
								.padding()
						} label : {
							UserRow(user: user)
						}
					}
					.searchable(text: $vm.userSearchText)
				}
				.toolbar{
					if(vm.api.appSession.user!.hasPermission(perm_id: "users.create")){
						ToolbarItem(placement: .primaryAction){
							Button{
								showCreateUser.toggle()
							} label: {
								Image(systemName: "plus")
							}
							.help("Create User")
						}
					}
					
					ToolbarItem(placement: .primaryAction){
						Button{
							Task{
								await vm.loadUsers()
							}
						} label: {
							Image(systemName: "arrow.clockwise")
						}
						.help("Reload Users")
					}
				}
			}
		}
		.task{
			await vm.loadUsers()
		}
		.sheet(isPresented: $showCreateUser){
			CreateUserView(vm: createVm)
				.globalErrorAlert(api: vm.api)
		}
    }
}

#Preview {
	let url = URL(string: "http://127.0.0.1:3000")
	let config = APIConfiguration(baseURL: url!)
	let api = VetrixAPI(configuration: config)
	UsersView(api: api)
}
