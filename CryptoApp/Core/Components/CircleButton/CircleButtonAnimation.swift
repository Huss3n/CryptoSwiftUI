//
//  CircleButtonAnimation.swift
//  CryptoApp
//
//  Created by Muktar Hussein on 06/11/2023.
//

import SwiftUI

struct CircleButtonAnimation: View {
    @Binding  var animate: Bool
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(animate ? Animation.easeOut(duration: 1.0) : .none)
    }
}

#Preview {
    CircleButtonAnimation(animate: .constant(true))
}
