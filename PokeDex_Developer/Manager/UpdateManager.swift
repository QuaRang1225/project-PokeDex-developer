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
        let pokemonManager = PokemonManager()
        
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
        
        
       
        //포켓몬 
//        let forms = try await pokemonSpeciesManager.get
//        pokemon["text_entries_text"] = try await pokemonManager.getFormsName(name: <#T##String#>)
        
        let treeData: [String: Any] = [
            "name": "Root",
            "children": [
                [
                    "name": "Child1",
                    "children": []
                ],
                [
                    "name": "Child2",
                    "children": [
                        [
                            "name": "Child2-1",
                            "children": []
                        ]
                    ]
                ]
            ]
        ]
        
        try await db.collection("trees").document("tree1").setData(treeData)
    }
    
}
