//
//  PokemonEvolutionInfo.swift
//  PokeDex_Developer
//
//  Created by 유영웅 on 3/26/24.
//

import Foundation

class PokemonEvolutionInfo:Identifiable{
    var id = UUID()
    var image:[String]
    var name:String
    var children:[PokemonEvolutionInfo]
    
    init(image: [String], name: String, children: [PokemonEvolutionInfo] = []) {
        self.image = image
        self.name = name
        self.children = children
    }
    
}
