//
//  ContentView.swift
//  PokeDex_Developer
//
//  Created by 유영웅 on 3/20/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var manager = PokemonManager()
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                HStack{
                    Image(systemName: "hare.fill")
                    Text("포켓몬정보")
                        .bold()
                }
                .foregroundStyle(.primary)
                .font(.title2)
                
            }
            .onAppear{
                Task{
                    print(Double(100 * (try await manager.getGenderRate(num: 1))/8))
                    print(try await manager.getEggGroups(num: 1))
                    print(try await manager.getGenra(num: 1))
                    print(try await manager.getFormsSwitchable(num: 1))
                    print(try await manager.getTextEntried(num: 1))
                    print(try await manager.getHatchCounter(num: 1))
                    print(try await manager.getName(num: 1))
                    print(try await manager.getPokdexNumbers(num: 1))
                }
                
            }
            .padding()
        }
        
    }
}

#Preview {
    ContentView()
}
