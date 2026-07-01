//
//  UserDetailView.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 01/07/2026.
//

import SwiftUI
import VetrixCore

struct UserDetailView: View {
	var user: User
	
	
    var body: some View {
		VStack{
			Circle()
				.fill(.blue.gradient)
				.frame(width: 88, height: 88)
				.overlay {
					Text("\(user.firstName.prefix(1))\(user.lastName.prefix(1))")
						.font(.largeTitle.bold())
						.foregroundStyle(.white)
				}
			
			VStack{
				Text("\(user.firstName) \(user.lastName)")
					.foregroundStyle(.black)
					.font(.title)
				
				Text("@\(user.username)")
					.foregroundStyle(.gray)
					.font(.subheadline)
				
				Text(user.email)
					.foregroundStyle(.gray)
					.font(.caption)
			}
			
			Spacer()
			
			HStack{
				List{}
				
				Spacer()
				
				List{}
			}
			.padding()
		}
    }
}

#Preview {
	UserDetailView(user: .preview)
}
