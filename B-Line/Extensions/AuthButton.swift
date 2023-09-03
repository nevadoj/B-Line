//
//  AuthButton.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-09-03.
//

import SwiftUI

struct AuthButton: View {
    
    var buttonLabel: String
    
    var body: some View {
        Text(buttonLabel)
            .foregroundColor(.white)
            .frame(maxWidth: UIScreen.main.bounds.width / 2)
            .frame(height: 60)
            .background(Color("BSecondary")
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.3), radius:6, x:4, y:5))
            .fontWeight(.semibold)
    }
}

struct AuthButton_Previews: PreviewProvider {
    static var previews: some View {
        AuthButton(buttonLabel: "Test")
    }
}
