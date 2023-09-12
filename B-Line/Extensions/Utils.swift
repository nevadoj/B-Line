//
//  Utils.swift
//  Example
//
//  Created by Alisa Mylnikova on 23.01.2023.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff

        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)
    }

    static var exampleGrey = Color(hex: "0C0C0C")
    static var exampleLightGrey = Color(hex: "#B1B1B1")
    static var examplePurple = Color(hex: "7D26FE")
}

extension String{
    func dateFromString(inputStr: String) -> Date{
        let dateFormatter = DateFormatter()
        if(inputStr.count > 7){
            dateFormatter.dateFormat = "h:mma yyyy-MM-dd"
        }
        else{
            dateFormatter.dateFormat = "h:mma"
        }
        
        return dateFormatter.date(from: inputStr) ?? Date()
    }
    
    func timeFromString(inputStr: String) -> String{
        let dateFormatter = DateFormatter()
        
        if(inputStr.count > 7){
            dateFormatter.dateFormat = "h:mma yyyy-MM-dd"
        }
        else{
            dateFormatter.dateFormat = "h:mma"
        }
        
        let date = dateFormatter.date(from: inputStr) ?? Date()
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "h:mma"
        
        return outputFormatter.string(from: date)
    }
}

extension View {
    /// Hide or show the view based on a boolean value.
    ///
    /// Example for visibility:
    ///
    ///     Text("Label")
    ///         .isHidden(true)
    ///
    /// Example for complete removal:
    ///
    ///     Text("Label")
    ///         .isHidden(true, remove: true)
    ///
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}
