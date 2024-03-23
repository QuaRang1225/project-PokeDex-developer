//
//  PokeminEvolutoinManager.swift
//  PokeDex_Developer
//
//  Created by 유영웅 on 3/23/24.
//

import Foundation
import PokemonAPI

protocol PokemonEvolution{
    func getEvolutionChainUrl(num:Int) async throws -> Int          //포켓몬 진화트리 요청 번호
}

class PokeminEvolutoinManager:ObservableObject{
    
    
    func getEvolutionChainUrl(num:Int) async throws -> Int{
        guard let url = try await PokemonAPI().pokemonService.fetchPokemonSpecies(num).evolutionChain?.url else {return 0}
        guard let dexNum = Int(URL(string: url)?.lastPathComponent ?? "") else {return 0}
        
        return dexNum
    }
    
}
