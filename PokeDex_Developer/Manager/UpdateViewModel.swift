//
//  UpdateManager.swift
//  PokeDex_Developer
//
//  Created by 유영웅 on 3/26/24.
//

import Foundation
import Alamofire

class UpdateViewModel:ObservableObject{
    
    
    private let pokemonSpeciesManager = PokemonSpeciesManager.shared
    private let pokemonEvolutionManager = PokemonEvolutoinManager.shared
    private let pokemonManager = PokemonManager.shared
    
    
    
    func storePokemon(num:Int)async throws -> (form : [String],chian: Int){
        let params = try await self.getPokemonSpecies(num: num)
       request(params: params, endPoint: "pokemon")
        return (params["varieties"] as! [String],params["evolution_tree"] as! Int)
    }
    func storePokemonVarieties(form:String)async throws{
        let params = try await self.getPokemon(form: form)
        request(params: params, endPoint: "variety")
    }
    func storePokemonEvolutionTree(num:Int)async throws{
        let params = try await self.getPokemonEvolution(num: num)
        print(params)
        request(params: params, endPoint: "tree")
    }
    func deletePokemon(num:Int)async throws{
        AF.request("http://\(Bundle.main.infoDictionary?["LOCAL_URL"] ?? "")/pokemon/\(num)", method: .delete)
            .validate()
            .response{ response in
                switch response.result {
                case .success(let value):
                    print("Response: \(String(describing: value))")
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
    }
    func updatePokemonInfo(num:Int) async throws{
        
        //포켓몬 데이터 mongoDB에 저장
        let pokemonData =  try await storePokemon(num: num)
        
        await withThrowingTaskGroup(of: Void.self) { group in
            for form in pokemonData.form{
                group.addTask {
                    try await self.storePokemonVarieties(form: form)
                }
            }
        }
        if !(try await pokemonSpeciesManager.getEvolutionFromSpecies(num: num)){
            try await storePokemonEvolutionTree(num: pokemonData.chian)
        }
    }
    
    
    
    
    func getPokemonSpecies(num: Int) async throws -> Parameters {
        async let dex = pokemonSpeciesManager.getPokdexNumbers(num: num)
        async let name = pokemonSpeciesManager.getName(num: num)
        async let genra = pokemonSpeciesManager.getGenra(num: num)
        async let eggGroups = pokemonSpeciesManager.getEggGroups(num: num)
        async let genderRate = pokemonSpeciesManager.getGenderRate(num: num)
        async let captureRate = pokemonSpeciesManager.getCaptureRate(num: num)
        async let hatchCounter = pokemonSpeciesManager.getHatchCounter(num: num)
        async let textEntries = pokemonSpeciesManager.getTextEntries(num: num)
        async let formsSwitchable = pokemonSpeciesManager.getFormsSwitchable(num: num)
        async let evolutionChainUrl = pokemonEvolutionManager.getEvolutionChainUrl(num: num)
        async let color = pokemonSpeciesManager.getColor(num: num)
        async let varieites =  pokemonSpeciesManager.getVarieties(num: num)
        async let types = pokemonManager.getTypes(num: num)
        let image =  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/\(num).png"
        
        return try await [
            "_id" : num,
            "color" : color,
            "base": [
                "types": types,
                "image": image
            ],
            "capture_rate": captureRate,
            "dex" : dex,
            "egg_group":  eggGroups,
            "evolution_tree": evolutionChainUrl,
            "forms_switchable": formsSwitchable,
            "gender_rate": genderRate,
            "genra": genra,
            "hatch_counter": hatchCounter,
            "name": name,
            "text_entries" : [
                "text": textEntries.text,
                "version" : textEntries.version
            ],
            "varieties" : varieites
        ] as Parameters
        
        
    }
    func getPokemon(form:String)async throws -> Parameters{
        
        async let formsImages = pokemonManager.getFormsImage(name: form, getOnlyForms: false)
        async let types = pokemonManager.getTypes(name: form)
        async let height = pokemonManager.getHeight(name: form)
        async let weight = pokemonManager.getWeight(name: form)
        async let abilites = pokemonManager.getAbilites(name: form)
        async let stats = pokemonManager.getStats(name: form)
        
        return try await[
            "_id" : form,
            "abilites" : [
                "name" : abilites.0,
                "text" : abilites.1,
                "is_hidden" : abilites.2,
            ],
            "form" : [
                "images" : formsImages[0],
                "name" : form
            ],
            "types" : types,
            "height" : height,
            "weight" : weight,
            "stats" : stats
        ] as Parameters
    }
    func getPokemonEvolution(num:Int) async throws -> Parameters{
        
        let chain = try await pokemonEvolutionManager.getEvolutionChain(num: num)
        
        var rootTree:[String:Any] = [:]
        var middleTree:[[String:Any]] = []
        var lastNode:[[String:Any]] = []
        
        rootTree["_id"] = num
        rootTree["name"] = chain.name
        rootTree["image"] = chain.image
        for child in chain.children{
            var middle:[String:Any] = [:]
            middle["name"] = child.name
            middle["image"] = child.image
            for ch in child.children{
                var last:[String:Any] = [:]
                last["name"] = ch.name
                last["image"] = ch.image
                last["evol_to"] = []
                lastNode.append(last)
            }
            middle["evol_to"] = lastNode
            middleTree.append(middle)
        }
        rootTree["evol_to"] = middleTree
        
        return rootTree as Parameters
        
    }
    
    
    private func request(params:Parameters,endPoint:String){
        AF.request("http://\(Bundle.main.infoDictionary?["LOCAL_URL"] ?? "")/\(endPoint)", method: .post, parameters: params, encoding: JSONEncoding.default)
            .validate()
            .response{ response in
                switch response.result {
                case .success(let value):
                    print("Response: \(String(describing: value))")
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
    }
}



