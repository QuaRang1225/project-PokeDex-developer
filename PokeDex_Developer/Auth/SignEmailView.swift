//
//  SignEmailView.swift
//  PokeDex_Developer
//
//  Created by 유영웅 on 3/26/24.
//

import SwiftUI

struct SignEmailView: View {
    
    @Binding var showSignView:Bool
    @StateObject private var vm = SignEmailViewModel()
    
    var body: some View {
        VStack{
            
            TextField("로그인",text: $vm.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            SecureField("비밀번호",text: $vm.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            Button {
                Task{
                    do{
                        showSignView = try await vm.signUp()
                        return  //리턴을 하지 못하면 다음으로 넘어감
                    } catch{
                        print(error)
                    }
                    do{
                        showSignView = try await vm.signIn()
                        return
                    } catch{
                        print(error)
                    }
                }
                
            } label: {
                Text("로그인")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.pink)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("로그인 및 회원가입")
    }
}

#Preview {
    SignEmailView(showSignView: .constant(false))
}
