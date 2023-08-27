//
//  LocationText.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-08-26.
//

import SwiftUI

struct LocationText: View {
    
    var imageName = ""
    var locationName = ""
    var color = Color(.white)
    var font: Font
    
    var body: some View {
        HStack{
            Image(systemName: imageName)
                .foregroundColor(color)
                .font(font)
            Text(locationName)
                .font(font)
                .fontWeight(.semibold)
                .foregroundColor(color)
        }
        .padding(.vertical, 1)
    }
}

struct LocationText_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color("BPrimary").ignoresSafeArea()
            LocationText(imageName: "bus.fill", locationName: "Langley Ctr", color: .white, font: .title2)
        }
    }
}
