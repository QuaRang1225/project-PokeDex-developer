//
//  UpdateManager.swift
//  PokeDex_Developer
//
//  Created by 유영웅 on 3/26/24.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

class UpdateManager{
    
    static let shared = UpdateManager()
    private init(){}
    
    private let db = Firestore.firestore()
    
    func updatePokemonSpecies(num:Int) async throws{
        
        let pokemonSpeciesManager = PokemonSpeciesManager()
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
        
        try await db.collection("pokemon").document("\(num)").setData(pokemon)
       
        //포켓몬 
        let forms = try await pokemonSpeciesManager.getVarieties(num: num)
        for form in forms{
            try await updatePokemon(form: form,num:num)
        }
        
        
    }
    
    func updatePokemon(form:String,num:Int)async throws{
        let pokemonManager = PokemonManager()
        
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
        
        try await db.collection("pokemon").document("\(num)").collection("varieites").document("\(form)").setData(pokemon)
        
    }
    
}
