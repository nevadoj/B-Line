//
//  LocationSearchMenuView.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-02-21.
//

import SwiftUI

struct LocationSearchMenuView: View {
    
    @State var inputText = ""
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                TextField("Search", text: $inputText)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width - 120, height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color("BSecondary"))
                            .opacity(0.7)
                            .shadow(color: Color("BSecondary"), radius: 5)
                    )
                    .padding(25)
                
//                PrimaryButton(imageName: "magnifyingglass") // switch image to 'X' with binding variable
//                    .padding([.vertical, .trailing], 25)
                Spacer()
            }
            
            ScrollView{
                VStack{
                    // show 'Search..' text with binding variable if TextField is empty
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                        .padding()
                }
            }
        }
        .background(Color("BPrimary"))
    }
}

struct LocationSearchMenuView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchMenuView()
    }
}
