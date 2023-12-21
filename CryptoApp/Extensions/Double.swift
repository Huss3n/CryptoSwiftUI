//
//  Double.swift
//  CryptoApp
//
//  Created by Muktar Hussein on 06/11/2023.
//

import Foundation

extension Double {
    
    
    /// Converts a double into a currency with 2 decimal places with the specified structure
    /// ```
    ///Converts 123.456 to $123.45
    ///Converts 1.23456 to $1.23
    ///Converts 0.123456 to $0.12
    /// ```
    private var currencyFormatter2Dp: NumberFormatter {
        let formater = NumberFormatter()
        formater.usesGroupingSeparator = true // <- separates using comas
        formater.numberStyle = .currency
        formater.minimumFractionDigits = 2
        formater.maximumFractionDigits = 2
//        formater.locale = .c // -> this formats the currency we receive
        formater.currencyCode = "usd"
        formater.currencySymbol = "$"
        return formater
    }
    
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2Dp.string(from: number) ?? "$0.00"
    }
    
    /// Converts a double into a currency with 2-6 decimal places with the specified structure
    /// ```
    ///Converts 1234.56 to $1,234.56
    ///Converts 12.3456 to $12.3456
    ///Converts 0.123456 to $0.123456
    /// ```
    private var currencyFormatter6Dp: NumberFormatter {
        let formater = NumberFormatter()
        formater.usesGroupingSeparator = true // <- separates using comas
        formater.numberStyle = .currency
        formater.minimumFractionDigits = 2
        formater.maximumFractionDigits = 6
//        formater.locale = .c // -> this formats the currency we receive
        formater.currencyCode = "usd"
        formater.currencySymbol = "$"
        return formater
    }
    
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6Dp.string(from: number) ?? "$0.00"
    }
    
    
    /// Converts a double into a string
    /// ```
    ///Converts 123.45 to "123.45
    /// ```
    private func removeDecimalPlaces() -> String {
        return String(format: "%.2f", self)
    }
    
    
    
    /// Converts a Double into string representation
    /// ```
    /// Convert 1.2345 to "1.23"
    /// ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// Converts a Double into string representation with percent symbol
     /// ```
     /// Convert 1.2345 to "1.23%"
     /// ```
     func asPercentString() -> String {
         return asNumberString() + "%"
     }
    
    /// Convert a Double to a String with K, M, Bn, Tr abbreviations.
      /// ```
      /// Convert 12 to 12.00
      /// Convert 1234 to 1.23K
      /// Convert 123456 to 123.45K
      /// Convert 12345678 to 12.34M
      /// Convert 1234567890 to 1.23Bn
      /// Convert 123456789012 to 123.45Bn
      /// Convert 12345678901234 to 12.34Tr
      /// ```
      func formattedWithAbbreviations() -> String {
          let num = abs(Double(self))
          let sign = (self < 0) ? "-" : ""

          switch num {
          case 1_000_000_000_000...:
              let formatted = num / 1_000_000_000_000
              let stringFormatted = formatted.asNumberString()
              return "\(sign)\(stringFormatted)Tr"
          case 1_000_000_000...:
              let formatted = num / 1_000_000_000
              let stringFormatted = formatted.asNumberString()
              return "\(sign)\(stringFormatted)Bn"
          case 1_000_000...:
              let formatted = num / 1_000_000
              let stringFormatted = formatted.asNumberString()
              return "\(sign)\(stringFormatted)M"
          case 1_000...:
              let formatted = num / 1_000
              let stringFormatted = formatted.asNumberString()
              return "\(sign)\(stringFormatted)K"
          case 0...:
              return self.asNumberString()

          default:
              return "\(sign)\(self)"
          }
      }
}
