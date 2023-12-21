//
//  StatisticsView.swift
//  CryptoApp
//
//  Created by Muktar Hussein on 13/12/2023.
//

import SwiftUI

struct StatisticsView: View {
    let stat: StatisticsModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(stat.title)
                .foregroundStyle(Color.theme.secondaryText)
                .font(.caption)
            
            Text(stat.value)
                .font(.headline)
                .bold()
            
            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(
                        Angle(degrees: (stat.percentageChange ?? 0) >= 0 ? 0 : 180))
                
                Text(stat.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundStyle((stat.percentageChange ?? 0 ) >= 0 ? Color.theme.green : Color.theme.red)
            .opacity(stat.percentageChange == nil ? 0.0 : 1.0)
        }
        
    }
}


struct StatisticsView_PreviewProvider: PreviewProvider {
    static var previews: some View {
        Group {
//            StatisticsView(stat: dev.stat1)
//                .previewLayout(.sizeThatFits)
//                .preferredColorScheme(.dark)
//            
//            StatisticsView(stat: dev.stat2)
//                .previewLayout(.sizeThatFits)
            
            
            StatisticsView(stat: dev.stat3)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
        .padding()
    }
}
