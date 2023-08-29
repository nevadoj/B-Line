//
//  AnnotationView.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-08-28.
//

import SwiftUI

struct AnnotationView: View {
    var body: some View {
        VStack{
            ZStack{
                Image(systemName: "triangle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color("BPrimary"))
                    .rotationEffect(Angle(degrees: 180))
                    .frame(width: 10, height: 10)
                    .offset(y: 17.1)
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color("BPrimary"))
                Image(systemName: "bus.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                    .foregroundColor(.white)
                    .offset(x: 0.3, y: 0.5)
            }
            
        }
    }
}

struct AnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        AnnotationView()
    }
}
