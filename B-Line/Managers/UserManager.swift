//
//  UserManager.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-09-06.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class UserManager{
    static let shared = UserManager()
    private init() {}

    
    func createNewUser(auth: AuthDataResultModel) async throws{
        var userData: [String:Any] = [
            "user_id" : auth.uid,
            "date_created" : Timestamp(),
        ]
        if let email = auth.email{
            userData["email"] = email
        }
        if let photoUrl = auth.photoUrl{
            userData["photo_url"] = photoUrl
        }
        
        try await Firestore.firestore().collection("users").document(auth.uid).setData(userData, merge: false)
    }
}
