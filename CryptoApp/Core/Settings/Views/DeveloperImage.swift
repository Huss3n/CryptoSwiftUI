//
//  DeveloperImage.swift
//  CryptoApp
//
//  Created by Muktar Hussein on 20/12/2023.
//

import SwiftUI

struct DeveloperImage: View {
    let url: URL = URL(string: "https://hussein-aisak.vercel.app/me.JPG")!
    var body: some View {
        AsyncImage(url: url) { returnedImage in
            returnedImage
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .overlay {
                    Circle()
                        .stroke(.black, lineWidth: 2.0)
                        .frame(width: 100, height: 100)
                }
                .shadow(radius: 10)
                .padding()
        } placeholder: {
            ProgressView()
        }
    }
}

#Preview {
    DeveloperImage()
}
