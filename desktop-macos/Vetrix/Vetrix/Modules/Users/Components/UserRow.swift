//
//  UserRow.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 26/06/2026.
//

import SwiftUI
import VetrixCore

struct UserRow: View {
	var user: UserSummary
	
    var body: some View {
		HStack(spacing: 16){
			Circle()
				.fill(.blue.gradient)
				.frame(width: 44, height: 44)
				.overlay {
					Text("\(user.firstName.prefix(1))\(user.lastName.prefix(1))")
						.font(.headline.bold())
						.foregroundStyle(.white)
				}
			
			VStack(alignment: .leading, spacing: 4){
				HStack{
					Text("\(user.firstName) \(user.lastName)")
						.font(.headline)
					
					Spacer()
					
					Label(
						user.isActive ? "Active" : "Inactive",
						systemImage: "circle.fill"
					)
					.font(.caption)
					.foregroundStyle(user.isActive ? .green : .secondary)
					.labelStyle(.titleAndIcon)
				}
				
				Text("@\(user.username)")
					.font(.subheadline)
					.foregroundStyle(.secondary)
				
				Text(user.email)
					.font(.footnote)
					.foregroundStyle(.secondary)
					.lineLimit(1)
			}
		}
		.padding(.vertical, 6)
    }
}

#Preview {
	UserRow(user: .preview)
}
