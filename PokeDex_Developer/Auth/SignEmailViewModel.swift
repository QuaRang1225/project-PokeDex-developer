//
//  SignEmailViewModel.swift
//  PokeDex_Developer
//
//  Created by 유영웅 on 3/26/24.
//

import SwiftUI

@MainActor
final class SignEmailViewModel:ObservableObject{
    
    @Published var email = ""
    @Published var password = ""
    
    func signUp() async throws -> Bool{
        guard !email.isEmpty,!password.isEmpty else{
            print("이메일과 패스워드를 입력하지 않았습니다.")
            return true
        }
        let _ = try await AuthManager.shared.createUser(email: email, password: password)
        print("가입 성공")
        return false
    }
    func signIn() async throws -> Bool{
        guard !email.isEmpty,!password.isEmpty else {
            print("이메일과 패스워드를 입력하지 않았습니다.")
            return true
        }
        try await AuthManager.shared.signInUser(email: email, password: password)
        print("인증 성공")
        return false
    }
    
}


