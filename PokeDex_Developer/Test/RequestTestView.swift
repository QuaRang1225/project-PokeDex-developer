//
//  RequestTesrView.swift
//  PokeDex_Developer
//
//  Created by 유영웅 on 3/26/24.
//

import SwiftUI

struct RequestTestView: View {
    @StateObject var speceisManager = PokemonSpeciesManager()
    @StateObject var manager = PokemonManager()
    @StateObject var evolutionManager = PokemonEvolutoinManager()
    
    @State var node: PokemonEvolutionInfo?
    
    var body: some View {
        VStack{
            if let node{
                EvolTreeNodeView(node: node)
            }
        }
        .onAppear{
            Task{
                let dex = 133
//                    print("===============================")
//                    print(Double(100 * (try await speceisManager.getGenderRate(num: dex))/8))
//                    print(try await speceisManager.getEggGroups(num: dex))
//                    print(try await speceisManager.getGenra(num: dex))
//                    print(try await speceisManager.getFormsSwitchable(num: dex))
//                    print(try await speceisManager.getTextEntried(num: dex))
//                    print(try await speceisManager.getHatchCounter(num: dex))
//                    print(try await speceisManager.getName(num: dex))
//                    print(try await speceisManager.getPokdexNumbers(num: dex))
//                    let varieties = try await speceisManager.getVarieties(num: dex)
//                    for vari in varieties{
//                        print("===============================")
//                        print(try await manager.getAbilites(name: vari))
//                        print(try await manager.getFormsName(name: vari))
//                        print(try await manager.getFormsImage(name: vari,getOnlyForms: false))
//                        print(try await manager.getHeight(name: vari))
//                        print(try await manager.getStats(name: vari))
//                        print(try await manager.getTypes(name: vari))
//                        print(try await manager.getWeight(name: vari))
//                    }
                
                node = try await evolutionManager.getEvolutionChain(num: 1)
            }
        }
    }
}

#Preview {
    RequestTestView()
}
