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
    
    func updatePokemonSpecies(num:Int) async throws{
        
        
        var pokemon:[String:Any] = [:]
        
        //포켓몬 종 정보
        pokemon["num"] = num
        pokemon["dex_region"] = try await pokemonSpeciesManager.getPokdexNumbers(num: num).0
        pokemon["dex_num"] = try await pokemonSpeciesManager.getPokdexNumbers(num: num).1
        pokemon["name"] = try await pokemonSpeciesManager.getName(num: num)
        pokemon["genra"] = try await pokemonSpeciesManager.getGenra(num: num)
        pokemon["egg_group"] = try await pokemonSpeciesManager.getEggGroups(num: num)
        pokemon["gender_rate"] = try await pokemonSpeciesManager.getGenderRate(num: num)
        pokemon["capture_rate"] = try await pokemonSpeciesManager.getCaptureRate(num: num)
        pokemon["hatch_counter"] = try await pokemonSpeciesManager.getHatchCounter(num: num)
        pokemon["text_entries_version"] = try await pokemonSpeciesManager.getTextEntries(num: num).0
        pokemon["text_entries_text"] = try await pokemonSpeciesManager.getTextEntries(num: num).1
        pokemon["forms_switchable"] = try await pokemonSpeciesManager.getFormsSwitchable(num: num)
        pokemon["evolution_tree"] = try await pokemonEvolutionManager.getEvolutionChainUrl(num: num)
        
//        print(pokemon)
//        try await db.collection("pokemon").document("\(num)").setData(pokemon)
       
        //포켓몬 
        let forms = try await pokemonSpeciesManager.getVarieties(num: num)
        for form in forms{
            try await updatePokemon(form: form,num:num)
        }
        if !(try await pokemonSpeciesManager.getEvolutionFromSpecies(num: num)){
            try await updatePokemonEvolution(num: try await pokemonEvolutionManager.getEvolutionChainUrl(num: num))
        }
    }
    
    func updatePokemon(form:String,num:Int)async throws{
        
        var pokemon:[String:Any] = [:]
        pokemon["forms_name"] = try await pokemonManager.getFormsName(name: form)
        pokemon["forms_images"] = try await pokemonManager.getFormsImage(name: form, getOnlyForms: false)
        pokemon["types"] = try await pokemonManager.getTypes(name: form)
        pokemon["height"] = try await pokemonManager.getHeight(name: form)
        pokemon["weight"] = try await pokemonManager.getWeight(name: form)
        pokemon["abilites_name"] = try await pokemonManager.getAbilites(name: form).0
        pokemon["abilites_text"] = try await pokemonManager.getAbilites(name: form).1
        pokemon["abilites_is_hidden"] = try await pokemonManager.getAbilites(name: form).2
        pokemon["stats_name"] = try await pokemonManager.getStats(name: form).0
        pokemon["stats"] = try await pokemonManager.getStats(name: form).1
        
//        print(pokemon)
//        try await db.collection("pokemon").document("\(num)").collection("varieites").document("\(form)").setData(pokemon)
        
    }
    
    func updatePokemonEvolution(num:Int) async throws{
        
  
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
        print(rootTree)
//        try await db.collection("evolution").document("\(num)").setData(rootTree)
    }
    
}
