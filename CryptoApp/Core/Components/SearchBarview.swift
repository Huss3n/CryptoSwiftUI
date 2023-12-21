//
//  SearchBarview.swift
//  CryptoApp
//
//  Created by Muktar Hussein on 10/12/2023.
//

import SwiftUI

struct SearchBarview: View {
    @Binding var searchtext: String
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(
                    searchtext.isEmpty ? Color.theme.secondaryText : Color.theme.accent
                )
            TextField("Search by name or symbol...", text: $searchtext)
                .foregroundStyle(Color.theme.accent)
                .autocorrectionDisabled()
                .overlay(alignment: .trailing) {
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10.0)
                        .foregroundStyle(Color.theme.accent)
                        .opacity(searchtext.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchtext = ""
                        }
                }
            
        }
        .font(.headline)
        .padding()
        .background(
        RoundedRectangle(cornerRadius: 25.0)
            .fill(Color.theme.background)
            .shadow(color: Color.theme.accent.opacity(0.2), radius: 10, x: 0.0, y: 0.0)
        )
        .padding()
    }
}

#Preview {
    SearchBarview(searchtext: .constant(""))
}
