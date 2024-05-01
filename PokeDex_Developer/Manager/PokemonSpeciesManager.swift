//
//  PokemonClass.swift
//  PokeDex_Developer
//
//  Created by 유영웅 on 3/21/24.
//

import Foundation
import PokemonAPI




class PokemonSpeciesManager:ObservableObject,PokemonSpecies{
    
    static let shared = PokemonSpeciesManager()
    private init(){}
    
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
    
    
    func getTextEntries(num:Int) async throws -> TextEntries{
        guard let textEntries = try await PokemonAPI().pokemonService.fetchPokemonSpecies(num).flavorTextEntries else { return TextEntries(text: [], version: []) }
        //한글로 되어있는 도감설명만 필터링
        let koreanFlavorTextEntries = textEntries.filter{$0.language?.name == "ko"}
        
        return TextEntries(text: koreanFlavorTextEntries.compactMap{$0.version?.name}.compactMap{VersionFilter(rawValue: $0)?.name}, version: koreanFlavorTextEntries.compactMap{$0.flavorText})
        
    }
    
    
    func getFormsSwitchable(num:Int) async throws -> Bool{
        return try await PokemonAPI().pokemonService.fetchPokemonSpecies(num).formsSwitchable ?? false
    }
    
    
    func getGenderRate(num:Int) async throws -> Int{
        return try await PokemonAPI().pokemonService.fetchPokemonSpecies(num).genderRate ?? 0
    }
    
    
    func getGenra(num:Int) async throws -> String{
        guard let genra = try await PokemonAPI().pokemonService.fetchPokemonSpecies(num).genera else { return ""}
        return genra.first(where: {$0.language?.name == "ko"})?.genus ?? ""
    }
    
    
    func getHatchCounter(num:Int) async throws -> Int{
        guard let hatchCounter = try await PokemonAPI().pokemonService.fetchPokemonSpecies(num).hatchCounter else { return 0}
        return hatchCounter
    }
    
    
    func getName(num:Int) async throws -> String{
        guard let names = try await PokemonAPI().pokemonService.fetchPokemonSpecies(num).names else { return ""}
        return names.first(where: {$0.language?.name == "ko"})?.name ?? ""
    }
    func getName(name:String) async throws -> String{
        guard let names = try await PokemonAPI().pokemonService.fetchPokemonSpecies(name).names else { return ""}
        return names.first(where: {$0.language?.name == "ko"})?.name ?? ""
    }
    
    func getPokdexNumbers(num:Int) async throws -> [[String:Any]]{
        guard let pokedexNumbers = try await PokemonAPI().pokemonService.fetchPokemonSpecies(num).pokedexNumbers else {return []}
        let koreanArea = pokedexNumbers.compactMap{AreaFilter(rawValue: $0.pokedex?.name ?? "")?.name}
        
        var dex = [[String:Any]]()
        zip(koreanArea,pokedexNumbers.compactMap{$0.entryNumber}).forEach { dex.append(["num" : $1 , "region" : $0]) }
        return dex
    }
    
    func getVarieties(num:Int) async throws -> [String]{
        guard let pokedexVarieties = try await PokemonAPI().pokemonService.fetchPokemonSpecies(num).varieties else {return([])}
        let varieties = pokedexVarieties.compactMap{$0.pokemon?.name}
        return varieties
    }
    func getVarieties(name:String) async throws -> [String]{
        guard let pokedexVarieties = try await PokemonAPI().pokemonService.fetchPokemonSpecies(name).varieties else {return([])}
        let varieties = pokedexVarieties.compactMap{$0.pokemon?.name}
        return varieties
    }
    func getCaptureRate(num:Int)async throws -> Int{
        guard let captureRate = try await PokemonAPI().pokemonService.fetchPokemonSpecies(num).captureRate else {return 0}
        return captureRate
    }
    func getEvolutionFromSpecies(num:Int) async throws -> Bool{
        guard  (try await PokemonAPI().pokemonService.fetchPokemonSpecies(num).evolvesFromSpecies != nil) else {return false}
        return true
    }
    func getColor(num:Int) async throws -> String {
        guard  let color = try await PokemonAPI().pokemonService.fetchPokemonSpecies(num).color?.name else {return ""}
        return color
    }
    func getEnglishName(num:Int) async throws -> String{
        guard  let name = try await PokemonAPI().pokemonService.fetchPokemonSpecies(num).name else {return ""}
        return name
    }
}
