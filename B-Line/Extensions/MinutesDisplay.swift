//
//  MinutesDisplay.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-08-26.
//

import SwiftUI

struct MinutesDisplay: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .frame(height: UIScreen.main.bounds.height / 6)
            .frame(maxWidth: UIScreen.main.bounds.width / 1.1)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color("BSecondary"))
                    .shadow(color: Color("BSecondary").opacity(0.5), radius: 8, x:3, y:6)
            )
    }
}

struct MinutesDisplay_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color("BPrimary").ignoresSafeArea()
            MinutesDisplay()
        }
    }
}
