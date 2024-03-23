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
    @StateObject var evolutionManager = PokeminEvolutoinManager()
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
                    let dex = 20
                    print("===============================")
                    print(Double(100 * (try await speceisManager.getGenderRate(num: dex))/8))
                    print(try await speceisManager.getEggGroups(num: dex))
                    print(try await speceisManager.getGenra(num: dex))
                    print(try await speceisManager.getFormsSwitchable(num: dex))
                    print(try await speceisManager.getTextEntried(num: dex))
                    print(try await speceisManager.getHatchCounter(num: dex))
                    print(try await speceisManager.getName(num: dex))
                    print(try await speceisManager.getPokdexNumbers(num: dex))
                    let varieties = try await speceisManager.getVarieties(num: dex)
                    for vari in varieties{
                        print("===============================")
                        print(try await manager.getAbilites(name: vari))
                        print(try await manager.getFormsName(name: vari))
                        print(try await manager.getFormsImage(name: vari))
                        print(try await manager.getHeight(name: vari))
                        print(try await manager.getStats(name: vari))
                        print(try await manager.getTypes(name: vari))
                        print(try await manager.getWeight(name: vari))
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
