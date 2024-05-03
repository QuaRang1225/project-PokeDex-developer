//
//  UpdateManager.swift
//  PokeDex_Developer
//
//  Created by 유영웅 on 3/26/24.
//

import Foundation
import Alamofire

class UpdateViewModel:ObservableObject{
    
    //DB저장 ==============================
    func storePokemon(num:Int)async throws -> (form : [String],chian: Int){
        let params = try await FetchParametersManager.shared.getPokemonSpecies(num: num)
        request(params: params,method: .post, endPoint: "pokemon")
        return (params["varieties"] as! [String],params["evolution_tree"] as! Int)
    }
    func storePokemonVarieties(form:String)async throws{
        let params = try await FetchParametersManager.shared.getPokemon(form: form)
        request(params: params,method: .post, endPoint: "variety")
    }
    func storePokemonEvolutionTree(num:Int)async throws{
        let params = try await FetchParametersManager.shared.getPokemonEvolution(num: num)
        request(params: params,method: .post, endPoint: "tree")
    }
    
    //DB읽기 =============================
    
    func deletePokemon(num:Int)async throws{
        request(params: Parameters(), method: .delete, endPoint: "pokemon/\(num)")
    }
    
    
    
    
    
    
   
    
    func updatePokemonInfo(num:Int) async throws{
        let pokemonSpeciesManager = PokemonSpeciesManager.shared
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
    private func request(params:Parameters,method:HTTPMethod,endPoint:String){
        AF.request("http://\(Bundle.main.infoDictionary?["LOCAL_URL"] ?? "")/\(endPoint)", method: method, parameters: params, encoding: JSONEncoding.default)
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



