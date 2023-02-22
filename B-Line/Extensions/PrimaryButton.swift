//
//  PrimaryButton.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-02-21.
//

import SwiftUI

struct PrimaryButton: View {
    
    var imageName: String = ""
    
    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .frame(width: 20, height: 20)
            .padding()
            .fontWeight(.semibold)
            .background(Color("BSecondary"))
            .foregroundColor(.white)
            .clipShape(Circle())
            .shadow(color: .black.opacity(0.5), radius: 3, x:0, y:0)
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(imageName: "magnifyingglass")
    }
}
