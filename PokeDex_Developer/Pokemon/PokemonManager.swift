//
//  PokemonManager.swift
//  PokeDex_Developer
//
//  Created by 유영웅 on 3/21/24.
//

import Foundation
import PokemonAPI

protocol Pokemon{
    func getAbilites(name:String) async throws -> ([String],[String],[Bool])            //특성/특성설명/숨은 특성인지
    func getKoreanAbilites(ability:String)async throws -> (String,String)               //한글 특성/한글 특성설명
    func getHeight(name:String) async throws -> Double                                  //키
}

class PokemonManager:ObservableObject,Pokemon{
    
    
    func getAbilites(name: String) async throws -> ([String],[String],[Bool]) {
        guard let pokemonAbilites = try await PokemonAPI().pokemonService.fetchPokemon(name).abilities else {return ([],[],[])}
        
        let abilities = pokemonAbilites.compactMap{$0.ability?.name}
        let abilitiesIsHidden = pokemonAbilites.compactMap{$0.isHidden}
        
        var pokemonKoreanAbilites:([String],[String]) = ([],[])
        
        for korean in abilities{
            let abilitesInfo = try await getKoreanAbilites(ability: korean)
            pokemonKoreanAbilites.0.append(abilitesInfo.0)
            pokemonKoreanAbilites.1.append(abilitesInfo.1)
        }
        
        return (pokemonKoreanAbilites.0,pokemonKoreanAbilites.1,abilitiesIsHidden)
    }
    
    func getKoreanAbilites(ability:String)async throws -> (String,String){
        let pokemonKoreanAbilites = try await PokemonAPI().pokemonService.fetchAbility(ability)
        
        let koreanName = pokemonKoreanAbilites.names?.first(where: {$0.language?.name == "ko"})?.name ?? ""
        let koreanText = pokemonKoreanAbilites.flavorTextEntries?.first(where: {$0.language?.name == "ko"})?.flavorText ?? ""
        
        return (koreanName,koreanText)
    }
    
    func getHeight(name:String) async throws -> Double{
        guard let height = try await PokemonAPI().pokemonService.fetchPokemon(name).height else { return 0 }
        return Double(height / 10)
    }
}
