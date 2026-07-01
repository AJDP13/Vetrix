//
//  CreateUserView.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 01/07/2026.
//

import SwiftUI
import VetrixCore

struct CreateUserView: View {
	@State var vm: CreateUserViewModel
	
	
    var body: some View {
		VStack{
			Text("Create New User")
				.font(.title2)
			
			Form{
				Section{
					TextField("First Name", text: $vm.firstName)
					TextField("Last Name", text: $vm.lastName)
				}
				
				Section{
					TextField("Email", text: $vm.email)
					TextField("Phone", text: $vm.phone)
				} header: {
					Text("Personal Information")
				}
				
				Section{
					TextField("Username", text: $vm.username)
					SecureField("Password", text: $vm.password)
					Toggle("Active", isOn: $vm.isActive)
						.toggleStyle(.checkbox)
				} header: {
					Text("Authentication Information")
				} footer :{
					Text("Invalid Password. Please use a minimum of 8 characters")
						.foregroundStyle(.red)
				}
			}
			.formStyle(.grouped)
			
			HStack{
				Spacer()
				
				Button("Cancel"){
					
				}
				
				Button("Create"){
					
				}
				.keyboardShortcut(.defaultAction)
				.disabled(!vm.canSubmit())
			}
		}
		.padding()
    }
}

#Preview {
	let api: VetrixAPI = VetrixAPI(configuration: .preview)
	CreateUserView(vm: CreateUserViewModel(api: api))
}
