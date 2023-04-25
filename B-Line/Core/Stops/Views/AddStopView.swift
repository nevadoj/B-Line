//
//  AddStopView.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-03-02.
//

import SwiftUI

struct AddStopView: View {
    
    @Environment (\.dismiss) var dismiss
    
    @State private var stopID = ""
    @State private var submit = false
    @ObservedObject private var viewModel = StopsViewModel()
    
    var body: some View {
        ZStack{
            Color("BPrimary").ignoresSafeArea()
            VStack(alignment: .leading){
                Text("Stop No.")
                    .padding(.top, 30)
                    .padding(.horizontal, 5)
                    .foregroundColor(Color(hex: "DCDCDC"))
                    .fontWeight(.semibold)
                
                TextField("Stop #", text: $stopID)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width - 50, height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color("BSecondary"))
                            .opacity(0.7)
                            .shadow(color: Color("BSecondary"), radius: 5)
                    )
                    .keyboardType(.numberPad)
                    .padding(.top, 5)
                    .onChange(of: stopID){ id in
                        submit = true
                        if(stopID.isEmpty){
                            submit = false
                        }
                    }
                
                if(submit){
                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8)){
                        HStack {
//                            PrimaryButton(imageName: "xmark")
//                                .padding()
//                                .onTapGesture {
//                                    stopID = ""
//                                }
//                            PrimaryButton(imageName: "checkmark")
//                                .padding()
//                                .onTapGesture {
//                                    // add to stops database
//                                    dismiss()
//                                }
                            Button(){
                                // add to stops database
                                viewModel.addStop(stopID: stopID)
                                dismiss()
                            } label: {
                                Text("Add")
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                            }
                            .frame(width: UIScreen.main.bounds.width - 250, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 18)
                                    .fill(Color("BSecondary"))
                                    .opacity(0.7)
                                    .shadow(color: Color("BSecondary"), radius: 5)
                            )
                            .padding(.top, 25)
                        }
                        .frame(width: UIScreen.main.bounds.width - 50)                        
                    }
                }
                
                Spacer()
            }
        }
    }
}

struct AddStopView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("BPrimary")
                .ignoresSafeArea()
            AddStopView()
        }
    }
}
