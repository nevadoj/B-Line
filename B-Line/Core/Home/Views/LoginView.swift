//
//  LoginView.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-09-03.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var emailFill = false
    @State private var passwordFill = false
    
    @Environment(\.dismiss) var dismiss
    @Binding var showStops: Bool
    
    let authMethod: UserAuth
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color("BPrimary").ignoresSafeArea()
                VStack(alignment: .leading){
                    Text("E-mail")
                        .frame(maxWidth: UIScreen.main.bounds.width / 4.5)
                        .font(.callout)
                        .foregroundColor(Color(hex: "DCDCDC"))
                        .padding(.horizontal)
                    
                    HStack{
                        Spacer()
                        TextField("", text: $email)
                            .frame(maxWidth: UIScreen.main.bounds.width / 1.3)
                            .padding()
                            .background(Color("BSecondary").opacity(0.5))
                            .cornerRadius(20)
                            .foregroundColor(.white)
                            .onChange(of: email){ email in
                                emailFill = true
                                if(email.isEmpty){
                                    emailFill = false
                                }
                            }
                        Spacer()
                    }
                    
                    Text("Password")
                        .frame(maxWidth: UIScreen.main.bounds.width / 3.5)
                        .font(.callout)
                        .foregroundColor(Color(hex: "DCDCDC"))
                        .padding(.top)
                        .padding(.horizontal)
                    
                    HStack{
                        Spacer()
                        SecureField("", text: $password)
                            .frame(maxWidth: UIScreen.main.bounds.width / 1.3)
                            .padding()
                            .background(Color("BSecondary").opacity(0.5))
                            .cornerRadius(20)
                            .foregroundColor(.white)
                            .onChange(of: password){ password in
                                passwordFill = true
                                if(password.isEmpty){
                                    passwordFill = false
                                }
                            }
                        Spacer()
                    }
                    
                    if(emailFill && passwordFill){
                        VStack(alignment: .center){
                            HStack(alignment: .center){
                                Spacer()
                                Button{
                                    Task{
                                        do{
                                            let _ = try await authMethod.submitAuth(email: email, password: password)
                                            // dismiss the view after
                                            showStops = true
                                            dismiss()
                                        }
                                        catch{
                                            print("Error authenticating user: \(error)")
                                        }
                                    }
                                } label: {
                                    AuthButton(buttonLabel: authMethod.flowText)
                                        .padding()
                                }
                                Spacer()
                            }
                        }
                    }
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(showStops: .constant(false), authMethod: AuthenticationSignIn())
    }
}
