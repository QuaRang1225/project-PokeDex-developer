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
    
    
    
    //알그룹
    func getEggGroups(num:Int) async throws -> [String]{
        
        var eggGroupsEnglishNames:[String] = []
        var eggGroupsKoreanNames = [String]()
        if let eggGroups = try await PokemonAPI().pokemonService.fetchPokemonSpecies(num).eggGroups{
            eggGroupsEnglishNames = eggGroups.compactMap{$0.name}
        }
        for name in eggGroupsEnglishNames{
            if let names = try await PokemonAPI().pokemonService.fetchEggGroup(name).names,let koreanName = names.first(where: {$0.language?.name == "ko"})?.name{
                eggGroupsKoreanNames.append(koreanName)
            }
        }
        return eggGroupsKoreanNames
    }
    
    //도감 설명
    func getTextEntried(num:Int) async throws -> ([String],[String]){
        guard let textEntries = try await PokemonAPI().pokemonService.fetchPokemonSpecies(num).flavorTextEntries else { return ([],[]) }
        //한글로 되어있는 도감설명만 필터링
        let koreanFlavorTextEntries = textEntries.filter{$0.language?.name == "ko"}
        
        let koreanTextEntriesList = (koreanFlavorTextEntries.compactMap{$0.flavorText},koreanFlavorTextEntries.compactMap{$0.version?.name}.compactMap{VersionFilter(rawValue: $0)?.name})
        return koreanTextEntriesList
        
    }
    
    //폼체인지 유무
    func getFormsSwitchable(num:Int) async throws -> Bool{
        return try await PokemonAPI().pokemonService.fetchPokemonSpecies(num).formsSwitchable ?? false
    }
    
    //성비
    func getGenderRate(num:Int) async throws -> Int{
        return try await PokemonAPI().pokemonService.fetchPokemonSpecies(num).genderRate ?? 0
    }
    
    //분류
    func getGenra(num:Int) async throws -> String{
        guard let genra = try await PokemonAPI().pokemonService.fetchPokemonSpecies(num).genera else { return ""}
        return genra.first(where: {$0.language?.name == "ko"})?.genus ?? ""
    }
    
    //부화 카운트
    func getHatchCounter(num:Int) async throws -> Int{
        guard let hatchCounter = try await PokemonAPI().pokemonService.fetchPokemonSpecies(num).hatchCounter else { return 0}
        return hatchCounter
    }
    
    //이름
    func getName(num:Int) async throws -> String{
        guard let names = try await PokemonAPI().pokemonService.fetchPokemonSpecies(num).names else { return ""}
        return names.first(where: {$0.language?.name == "ko"})?.name ?? ""
    }
    func getPokdexNumbers(num:Int) async throws -> ([String],[Int]){
        guard let pokedexNumbers = try await PokemonAPI().pokemonService.fetchPokemonSpecies(num).pokedexNumbers else {return([],[])}
        let koreanArea = pokedexNumbers.compactMap{AreaFilter(rawValue: $0.pokedex?.name ?? "")?.name}
        return (koreanArea,pokedexNumbers.compactMap{$0.entryNumber})
    }
    
}
