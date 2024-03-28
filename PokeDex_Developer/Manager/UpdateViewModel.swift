//
//  UpdateManager.swift
//  PokeDex_Developer
//
//  Created by 유영웅 on 3/26/24.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

class UpdateViewModel:ObservableObject{
    
    private let db = Firestore.firestore()
    private let pokemonSpeciesManager = PokemonSpeciesManager.shared
    private let pokemonEvolutionManager = PokemonEvolutoinManager.shared
    private let pokemonManager = PokemonManager.shared
    
    func updatePokemonInfo(num:Int) async throws{
        
        //포켓몬 데이터 firestore에 저장
        let pokemonSpecies = try await self.getPokemonSpecies(num: num)
        try await db.collection("pokemon").document("\(num)").setData(pokemonSpecies)
        
        //포켓몬
        let forms = try await pokemonSpeciesManager.getVarieties(num: num)
        await withThrowingTaskGroup(of: Void.self) { group in
            for form in forms{
                group.addTask {
                    let pokemon = try await self.getPokemon(form: form,num:num)
                    try await self.db.collection("pokemon").document("\(num)").collection("varieites").document("\(form)").setData(pokemon)
                }
            }
        }
        //포켓몬 진화트리
        if !(try await pokemonSpeciesManager.getEvolutionFromSpecies(num: num)){
            let chainNum = try await pokemonEvolutionManager.getEvolutionChainUrl(num: num)
            let chainDic = try await getPokemonEvolution(num:chainNum)
            try await db.collection("evolution").document("\(num)").setData(chainDic)
        }
    }
    
    
    
    
    func getPokemonSpecies(num: Int) async throws -> [String: Any] {
        async let dexNumbers = pokemonSpeciesManager.getPokdexNumbers(num: num)
        async let name = pokemonSpeciesManager.getName(num: num)
        async let genra = pokemonSpeciesManager.getGenra(num: num)
        async let eggGroups = pokemonSpeciesManager.getEggGroups(num: num)
        async let genderRate = pokemonSpeciesManager.getGenderRate(num: num)
        async let captureRate = pokemonSpeciesManager.getCaptureRate(num: num)
        async let hatchCounter = pokemonSpeciesManager.getHatchCounter(num: num)
        async let textEntries = pokemonSpeciesManager.getTextEntries(num: num)
        async let formsSwitchable = pokemonSpeciesManager.getFormsSwitchable(num: num)
        async let evolutionChainUrl = pokemonEvolutionManager.getEvolutionChainUrl(num: num)
        
        
        return try await [
            "num" : num,
            "dex_region": dexNumbers.0,
            "dex_num": dexNumbers.1,
            "name": name,
            "genra": genra,
            "egg_group":  eggGroups,
            "gender_rate": genderRate,
            "capture_rate": captureRate,
            "hatch_counter": hatchCounter,
            "text_entries_version": textEntries.0,
            "text_entries_text": textEntries.1,
            "forms_switchable": formsSwitchable,
            "evolution_tree": evolutionChainUrl
        ] as [String : Any]
    }
    func getPokemon(form:String,num:Int)async throws -> [String:Any]{
  
        async let formsName = pokemonManager.getFormsName(name: form)
        async let formsImages = pokemonManager.getFormsImage(name: form, getOnlyForms: false)
        async let types = pokemonManager.getTypes(name: form)
        async let height = pokemonManager.getHeight(name: form)
        async let weight = pokemonManager.getWeight(name: form)
        async let abilites = pokemonManager.getAbilites(name: form)
        async let stats = pokemonManager.getStats(name: form)
        
        return try await[
            "forms_name" : formsName,
            "forms_images" : formsImages,
            "types" : types,
            "height" : height,
            "weight" : weight,
            "abilites_name" : abilites.0,
            "abilites_text" : abilites.1,
            "abilites_isHidden" : abilites.2,
            "stats_name" : stats.0,
            "stats" : stats.1
            
            
        ]
    }
    func getPokemonEvolution(num:Int) async throws -> [String:Any]{
        
        let chain = try await pokemonEvolutionManager.getEvolutionChain(num: num)
        
        var rootTree:[String:Any] = [:]
        var middleTree:[[String:Any]] = []
        var lastNode:[[String:Any]] = []
        
        rootTree["name"] = chain.name
        rootTree["images"] = chain.image
        for child in chain.children{
            var middle:[String:Any] = [:]
            middle["name"] = child.name
            middle["images"] = child.image
            for ch in child.children{
                var last:[String:Any] = [:]
                last["name"] = ch.name
                last["images"] = ch.image
                lastNode.append(last)
                
            }
            middle["evol_to"] = lastNode
            middleTree.append(middle)
        }
        rootTree["evol_to"] = middleTree
        
        return rootTree
        
    }
}



