//
//  LocationSearchResult.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-02-22.
//

import SwiftUI

struct LocationSearchResult: View {
    let name: String
    let address: String
    
    var body: some View {
        VStack(alignment: .leading){
            VStack(alignment: .leading){
                Text(name)
                    .foregroundColor(.white)
                    .font(.title3)
                .fontWeight(.semibold)
                Text(address)
                    .foregroundColor(Color(hex: "DCDCDC"))
            }
            .padding(.horizontal, 25)
            
            Divider()
                .frame(minHeight: 2)
                .overlay(Color(.secondarySystemFill))
                .padding(.horizontal)
        }
    }
}

struct LocationSearchResult_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color("BPrimary").ignoresSafeArea()
            LocationSearchResult(name: "Location", address: "Address 91st, 123456, Sample")
        }
    }
}
