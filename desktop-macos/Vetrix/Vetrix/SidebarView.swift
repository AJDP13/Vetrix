//
//  SidebarView.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 26/06/2026.
//

import SwiftUI

struct SidebarView: View {
	@Bindable var vm: MainViewModel
	
	
    var body: some View {
		VStack(alignment: .leading){
			Button("Dashboard"){
				vm.destination = .dashboard
			}
			
			Button("Users"){
				vm.destination = .users
			}
			
			Spacer()
			
			Button("Settings"){
				vm.destination = .settings
			}
		}
		.frame(width: 220)
    }
}

#Preview {
	SidebarView(vm: MainViewModel())
}
