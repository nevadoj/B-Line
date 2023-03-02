//
//  StopViewCell.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-02-27.
//

import SwiftUI

struct StopViewCell: View {
    var body: some View {
        VStack(alignment: .leading){
            HStack(){
                VStack(alignment: .leading){
                    Text("502")
                        .font(.title)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.horizontal, 25)
                    Text("58946")
                        .padding(.horizontal, 25)
                        .fontWeight(.medium)
                        .foregroundColor(Color(hex: "DCDCDC"))
                    Text("Fraser Hwy @ 159 St")
                        .padding(.horizontal, 25)
                        .fontWeight(.medium)
                        .foregroundColor(Color(hex: "DCDCDC"))
                }
                Spacer()
                VStack{
                    Text("10")
                        .padding(.horizontal, 25)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.title2)
                    Text("mins")
                        .foregroundColor(Color(hex: "DCDCDC"))
                }
            }
        }
        .frame(height: UIScreen.main.bounds.height / 6)
        .frame(maxWidth: UIScreen.main.bounds.width / 1.1)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color("BSecondary"))
                .shadow(color: Color("BSecondary").opacity(0.5), radius: 8, x:3, y:6)
        )
    }
}

struct StopViewCell_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("BPrimary").ignoresSafeArea()
            StopViewCell()
        }
    }
}
