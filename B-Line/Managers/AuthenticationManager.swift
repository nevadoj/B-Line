//
//  AuthenticationManager.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-09-01.
//

import Foundation
import FirebaseAuth
import Swift

enum AuthError: Error{
    case RetrieveUserError
}

struct AuthDataResultModel{
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User){
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}

protocol UserAuth {
    func submitAuth(email: String, password: String) async throws -> AuthDataResultModel
    var flowText: String { get }
}

class AuthenticationSignIn: UserAuth{
    @discardableResult
    func submitAuth(email: String, password: String) async throws -> AuthDataResultModel {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: result.user)
    }
    
    var flowText = "Login"
}

class AuthenticationCreateAccount: UserAuth{
    @discardableResult
    func submitAuth(email: String, password: String) async throws -> AuthDataResultModel{
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: result.user)
    }
    
    var flowText = "Create Account"
}

class AuthenticationManager{
    
    static let shared = AuthenticationManager()
    private init() {}
    
    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthDataResultModel{
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: result.user)
    }
    
    func getAuthenticatedUser() throws -> AuthDataResultModel{
        guard let user = Auth.auth().currentUser else{
            throw AuthError.RetrieveUserError
        }
        
        return AuthDataResultModel(user: user)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
}

