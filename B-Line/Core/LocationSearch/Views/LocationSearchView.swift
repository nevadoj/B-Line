//
//  LocationSearchView.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-02-11.
//

import SwiftUI

struct LocationSearchView: View {
    var body: some View {
        HStack{
            
            Text("Search")
                .foregroundColor(.secondary)
                .padding()
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 64, height: 50)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .opacity(0.7)
                .shadow(color: .gray, radius: 5)
        )
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView()
    }
}
