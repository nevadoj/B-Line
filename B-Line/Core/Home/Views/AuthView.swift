//
//  AuthView.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-09-02.
//

import SwiftUI

struct AuthView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    // TODO: Separate views for signing in / creating account (by different buttons)
    
    var body: some View {
        VStack{
            Text("Sign in to view saved stops")
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .font(.headline)
                .padding()
            VStack(alignment: .leading){
                Text("E-mail")
                    .font(.callout)
                    .foregroundColor(Color(hex: "DCDCDC"))
                    .frame(maxWidth: UIScreen.main.bounds.width / 5.7)
                TextField("", text: $email)
                    .padding()
                    .background(Color("BSecondary").opacity(0.5))
                    .cornerRadius(20)
                    .frame(maxWidth: UIScreen.main.bounds.width / 1.2)
                    .foregroundColor(.white)
                
                Text("Password")
                    .font(.callout)
                    .foregroundColor(Color(hex: "DCDCDC"))
                    .frame(maxWidth: UIScreen.main.bounds.width / 4)
                    .padding(.top)
                SecureField("", text: $password)
                    .padding()
                    .background(Color("BSecondary").opacity(0.5))
                    .cornerRadius(20)
                    .frame(maxWidth: UIScreen.main.bounds.width / 1.2)
                    .foregroundColor(.white)
            }
        }
        .navigationTitle("Stops")
        .frame(maxWidth: .infinity)
        .background(Color("BPrimary"))
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color("BPrimary")
                .ignoresSafeArea()
            AuthView()
        }
    }
}
