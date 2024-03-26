//
//  AuthManager.swift
//  PokeDex_Developer
//
//  Created by 유영웅 on 3/26/24.
//

import Foundation
import FirebaseAuth

struct AuthDataResult{
    let uid:String
    let email:String?
    
    init(user:User) {   //코드의 간결성을 위해 같은 메서드의 값일 경우 이렇게 일체화 가능
        self.uid = user.uid
        self.email = user.email
    }
}

final class AuthManager{
    
    static let shared = AuthManager()
    private init(){}    //중복된 객체 생성 방지
    
    func createUser(email:String,password:String) async throws-> AuthDataResult{
        let authDataResult = try await Auth.auth().createUser(withEmail:email,password:password)
        return AuthDataResult(user: authDataResult.user)
        
    }
    
    @discardableResult
    func signInUser(email:String,password:String) async throws-> AuthDataResult{
        let authDataResult = try await Auth.auth().signIn(withEmail:email,password:password)
        return AuthDataResult(user: authDataResult.user)
        
    }
    func getUser() throws -> AuthDataResult{        
        guard let user = Auth.auth().currentUser else{
            throw URLError(.badServerResponse)
        }
        return AuthDataResult(user: user)
    }
    
    func logout() throws{
        try Auth.auth().signOut()
    }
}
