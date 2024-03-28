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
        async let dexNumbers = self.pokemonSpeciesManager.getPokdexNumbers(num: num)
        async let name =  self.pokemonSpeciesManager.getName(num: num)
        async let genra =  self.pokemonSpeciesManager.getGenra(num: num)
        async let eggGroups =  self.pokemonSpeciesManager.getEggGroups(num: num)
        async let genderRate =  self.pokemonSpeciesManager.getGenderRate(num: num)
        async let captureRate = self.pokemonSpeciesManager.getCaptureRate(num: num)
        async let hatchCounter =  self.pokemonSpeciesManager.getHatchCounter(num: num)
        async let textEntries =  self.pokemonSpeciesManager.getTextEntries(num: num)
        async let formsSwitchable =  self.pokemonSpeciesManager.getFormsSwitchable(num: num)
        async let evolutionChainUrl =  self.pokemonEvolutionManager.getEvolutionChainUrl(num: num)
        
        
        return await [
            "num" : num,
            "dex_region": try dexNumbers.0,
            "dex_num": try dexNumbers.1,
            "name": try name,
            "genra": try genra,
            "egg_group": try eggGroups,
            "gender_rate": try genderRate,
            "capture_rate": try captureRate,
            "hatch_counter": try hatchCounter,
            "text_entries_version": try textEntries.0,
            "text_entries_text": try textEntries.1,
            "forms_switchable": try formsSwitchable,
            "evolution_tree": try evolutionChainUrl
        ] as [String : Any]
    }
    func getPokemon(form:String,num:Int)async throws -> [String:Any]{
  
        async let formsName = pokemonManager.getFormsName(name: form)
        async let formsImages = try await pokemonManager.getFormsImage(name: form, getOnlyForms: false)
        async let types = try await pokemonManager.getTypes(name: form)
        async let height = try await pokemonManager.getHeight(name: form)
        async let weight = try await pokemonManager.getWeight(name: form)
        async let abilites = try await pokemonManager.getAbilites(name: form)
        async let stats = try await pokemonManager.getStats(name: form)
        
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



