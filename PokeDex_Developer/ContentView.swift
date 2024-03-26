//
//  ContentView.swift
//  PokeDex_Developer
//
//  Created by 유영웅 on 3/20/24.
//

import SwiftUI

struct EvolTreeNodeView: View {
    let items = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
    let node: PokemonEvolutionInfo
    
    var body: some View {
        VStack {
            Circle()
                .fill(Color.blue)
                .frame(width: 80, height: 80)
                .overlay(
                    Text("\(node.name)")
                        .foregroundColor(.white)
                        .font(.headline)
                )
                .padding()
            HStack (alignment: .top){
                if node.children.count > 3{
                    LazyVGrid(columns: items){
                        ForEach(node.children) { child in
                            EvolTreeNodeView(node: child)
                                .padding()
                        }
                    }
                    
                }else{
                    ForEach(node.children) { child in
                        EvolTreeNodeView(node: child)
                    }
                }
            }
        }
    }
}
struct ContentView: View {
    @StateObject var speceisManager = PokemonSpeciesManager()
    @StateObject var manager = PokemonManager()
    @StateObject var evolutionManager = PokeminEvolutoinManager()
    
    @State var node: PokemonEvolutionInfo?
    
    var body: some View {
        ScrollView{
//            VStack(alignment: .leading){
//                HStack{
//                    Image(systemName: "hare.fill")
//                    Text("포켓몬정보")
//                        .bold()
//                }
//                .foregroundStyle(.primary)
//                .font(.title2)
//                
//            }
            if let node{
                EvolTreeNodeView(node: node)
                    .padding()
            }
            
            
        }.onAppear{
            Task{
                let dex = 493
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
                
                node = try await evolutionManager.getEvolutionChainUrl(num: dex)
            }
        }
        
    }
}

#Preview {
    ContentView()
}
