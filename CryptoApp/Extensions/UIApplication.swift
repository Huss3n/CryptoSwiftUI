//
//  UIApplication.swift
//  CryptoApp
//
//  Created by Muktar Hussein on 10/12/2023.
//

import Foundation
import SwiftUI

extension UIApplication {
    // this function when called ends the editing thats going on and dismisses the keyboard
    /**
     The action resignFirstResponder is a method of the UIResponder protocol, which is adopted by various UI elements, including text fields and text views. Calling resignFirstResponder on an active UI element dismisses the keyboard and ends the editing session.
     */
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
