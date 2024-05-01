//
//  ContentView.swift
//  PokeDex_Developer
//
//  Created by 유영웅 on 3/20/24.
//

import SwiftUI


struct ContentView: View {
    
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
            
        }
        .padding(.horizontal)
    }
}
