//
//  EvolTreeNodeView.swift
//  PokeDex_Developer
//
//  Created by 유영웅 on 3/26/24.
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

#Preview {
    EvolTreeNodeView(node:PokemonEvolutionInfo(image: [], name: ""))
}
