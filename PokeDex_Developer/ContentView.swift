//
//  ContentView.swift
//  PokeDex_Developer
//
//  Created by 유영웅 on 3/20/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var speceisManager = PokemonSpeciesManager()
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
//                    print(Double(100 * (try await speceisManager.getGenderRate(num: 1))/8))
//                    print(try await speceisManager.getEggGroups(num: 1))
//                    print(try await speceisManager.getGenra(num: 1))
//                    print(try await speceisManager.getFormsSwitchable(num: 1))
//                    print(try await speceisManager.getTextEntried(num: 1))
//                    print(try await speceisManager.getHatchCounter(num: 1))
//                    print(try await speceisManager.getName(num: 1))
//                    print(try await speceisManager.getPokdexNumbers(num: 1))
//                    print(try await speceisManager.getVarieties(num: 1))
                    
                    
                    
                    let varieties = try await speceisManager.getVarieties(num: 20)
                    for vari in varieties{
                        print("===============================")
                        print(try await manager.getAbilites(name: vari))
                        print(try await manager.getForms(name: vari))
                        print(try await manager.getHeight(name: vari))
                        print(try await manager.getStats(name: vari))
                        print(try await manager.getTypes(name: vari))
                    }
                    
                }
            }
            .padding()
        }
        
    }
}

#Preview {
    ContentView()
}
