//
//  String.swift
//  CryptoApp
//
//  Created by Muktar Hussein on 19/12/2023.
//

import Foundation

extension String {
    
    
    var removingHTMLOccurences: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }
}
