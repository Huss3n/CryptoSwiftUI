//
//  CircleButton.swift
//  CryptoApp
//
//  Created by Muktar Hussein on 06/11/2023.
//

import SwiftUI

struct CircleButton: View {
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundStyle(Color.theme.accent)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundStyle(Color.theme.background)
            )
            .shadow(
                color: Color.theme.accent.opacity(0.25),
                radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/,
                x: 0.0, y: 0.0
            )
            .padding()
    }
}


struct CircleButton_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            CircleButton(iconName: "info")
                .previewLayout(.sizeThatFits)
            
            CircleButton(iconName: "plus")
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}


