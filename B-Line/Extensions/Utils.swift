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

// from: https://medium.com/devtechie/dynamically-hiding-view-in-swiftui-e7960d79a681
struct IsHidden: ViewModifier {
    var hidden = false
    var remove = false
    func body(content: Content) -> some View {
        if hidden {
            if remove {
                
            } else {
                content.hidden()
            }
        } else {
            content
        }
    }
}

extension View {
    func isHidden(hidden: Bool = false, remove: Bool = false) -> some View {
        modifier(
            IsHidden(
                hidden: hidden,
                remove: remove))
    }
}
