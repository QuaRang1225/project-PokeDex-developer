//
//  ContentView.swift
//  PokeDex_Developer
//
//  Created by 유영웅 on 3/20/24.
//

import SwiftUI


struct ContentView: View {
    @State private var showSignInView = false
    
    
    var body: some View {
        
        
        ScrollView{
            LazyVStack(pinnedViews: .sectionHeaders){
                Section(header:header){
                    VStack(alignment: .leading){
                        PokemonInfoView()
                    }
                    .foregroundStyle(.primary)
                }
            }
            
        }
        .onAppear{
            let authUser = try? AuthManager.shared.getUser()  //오류메세지를 확인할 필요가 없으니까 굳이 do catch로 나눌 필요가 앖음
            self.showSignInView = authUser == nil ? true:false  //유저 정보가 저장되어있을 경우 세
        }
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack{
                SignEmailView(showSignView: $showSignInView)
            }
            
        }
    }
}

#Preview {
    ContentView()
}

extension ContentView{
    var header:some View{
        HStack(alignment: .bottom){
            Text("포켓몬DB 대시보드")
                .bold()
                .font(.title)
            Spacer()
            Button {
                do{
                    try AuthManager.shared.logout()
                    showSignInView = true
                }
                catch{
                    print(error)
                }
                
            } label: {
                Text("로그아웃")
            }
            
        }
        .padding(.horizontal)
    }
}
