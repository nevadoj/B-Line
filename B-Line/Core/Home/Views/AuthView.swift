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
    @Binding var showStops: Bool
    
    
    // TODO: Separate views for signing in / creating account (by different buttons)
    init(showStops: Binding<Bool>){
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = UIColor.clear
        appearance.backgroundColor = UIColor(Color("BPrimary"))
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        _showStops = showStops
    }
    
    
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color("BPrimary").ignoresSafeArea()
                VStack(alignment: .center){
                    Text("Sign in to view saved stops")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .font(.headline)
                        .padding()
                    
                    NavigationLink{
                        LoginView(showStops: $showStops, authMethod: AuthenticationSignIn())
                            .navigationTitle("Login")
                            .toolbarRole(.editor)
                    } label: {
                        AuthButton(buttonLabel: "Login")
                            .padding()
                    }
                    
                    NavigationLink{
                        LoginView(showStops: $showStops, authMethod: AuthenticationCreateAccount())
                            .navigationTitle("Create Account")
                            .toolbarRole(.editor)
                    } label: {
                        AuthButton(buttonLabel: "Create Account")
                    }
                }
            }            
        }
        .tint(.white)
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            AuthView(showStops: .constant(false))
        }
    }
}
