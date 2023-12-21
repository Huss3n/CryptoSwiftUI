//
//  XmarkButton.swift
//  CryptoApp
//
//  Created by Muktar Hussein on 13/12/2023.
//

import SwiftUI

struct XmarkButton: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
        }

    }
}

#Preview {
    XmarkButton()
}
