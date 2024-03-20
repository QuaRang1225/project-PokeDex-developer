//
//  PokemonClass.swift
//  PokeDex_Developer
//
//  Created by 유영웅 on 3/21/24.
//

import Foundation
import PokemonAPI

//struct PokemonSpecies{
//    var eggGroups:[String]
//    
//    init(){
//        self.eggGroups = []
//    }
//}

class PokemonManager:ObservableObject{
    
    
//    func getPokemonSpecies() async throws{
//        var pokemonSpecies = PokemonSpecies()
//        
//    }
    
    func getEggGroups() async throws -> [String]{
        var eggGroupsEnglishNames:[String] = []
        var eggGroupsKoreanNames = [String]()
        if let eggGroups = try await PokemonAPI().pokemonService.fetchPokemonSpecies(1).eggGroups{
            eggGroupsEnglishNames = eggGroups.compactMap{$0.name}
        }
        for name in eggGroupsEnglishNames{
            if let names = try await PokemonAPI().pokemonService.fetchEggGroup(name).names,let koreanName = names.first(where: {$0.language?.name == "ko"})?.name{
                eggGroupsKoreanNames.append(koreanName)
            }
        }
        return eggGroupsKoreanNames
    }
}
