//
//  LocationSearchMenuView.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-02-21.
//

import SwiftUI

struct LocationSearchMenuView: View {
    
    @EnvironmentObject var viewModel: LocationViewModel
    @Binding var showSearchMenu: Bool
    @Binding var defaultLocation: Bool
    @Binding var showNavBar: Bool
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                TextField("Search", text: $viewModel.queryFragment)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width - 120, height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color("BSecondary"))
                            .opacity(0.7)
                            .shadow(color: Color("BSecondary"), radius: 5)
                    )
                    .padding(.horizontal, 25)
                    .padding(.top, 42)
                    .padding(.bottom, 25)
                
                Spacer()
            }
            
            ScrollView{
                VStack(alignment: .leading){
                    if(viewModel.queryFragment.isEmpty){
                        HStack{
                            Text("Search..")
                                .font(.title)
                                .foregroundColor(Color(hex: "DCDCDC"))
                                .fontWeight(.medium)
                          .font(.title2)
                        }
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 300)
                    }
                    else{
                        ScrollView{
                            VStack(alignment: .leading){
                                ForEach(viewModel.results, id: \.self){ result in
                                    LocationSearchResult(name: result.title, address: result.subtitle)
                                        .onTapGesture {
                                            viewModel.selectLocation(result)
                                            showSearchMenu.toggle()
                                            showNavBar.toggle()
                                            
                                            
                                            if(defaultLocation){
                                                defaultLocation.toggle()
                                            }
                                        }
                                }
                            }
                        }
                    }
                }
            }
        }
        .background(Color("BPrimary"))
    }
}

struct LocationSearchMenuView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchMenuView(showSearchMenu: .constant(true), defaultLocation: .constant(true), showNavBar: .constant(true))
            .environmentObject(LocationViewModel())
    }
}
