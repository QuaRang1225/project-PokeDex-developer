//
//  UpdateManager.swift
//  PokeDex_Developer
//
//  Created by 유영웅 on 3/26/24.
//

import Foundation
import Alamofire
import Combine

class UpdateViewModel:ObservableObject{
    
    @Published var pokemon:Pokemons? = nil
    @Published var pokemonList:PokemonPages? = nil
    
    @Published var query:Parameters = ["page": 1, "region": "전국", "types_1": "", "types_2": "", "query": ""]
    var cancelable = Set<AnyCancellable>()
    
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
    func fetchPokemon(num:Int) async throws{
        requestDecodable(params: nil, method: .get, endPoint: "pokemon/\(num)",encoding: JSONEncoding.default) { [weak self] (data : PokemonResponse) in
            self?.pokemon = data.data
        }
    }
    func fetchPokemons() async throws{
        requestDecodable(params: query, method: .get, endPoint: "pokemon",encoding: URLEncoding.queryString){ [weak self] (data : PokemonListResponse) in
            self?.pokemonList = data.data
        }
    }
    func fetchPokemonVarieties(form:String)async throws{
        let params = try await FetchParametersManager.shared.getPokemon(form: form)
        request(params: params,method: .post, endPoint: "variety")
    }
    func fetchPokemonEvolutionTree(num:Int)async throws{
        let params = try await FetchParametersManager.shared.getPokemonEvolution(num: num)
        request(params: params,method: .post, endPoint: "tree")
    }
    
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
    private func requestDecodable<T:Decodable>(params:Parameters?,method:HTTPMethod,endPoint:String,encoding:ParameterEncoding,save:@escaping ((T) -> Void)){
//        var requset: DataRequest? = nil
//        if let params{
//           requset = AF.request("http://\(Bundle.main.infoDictionary?["LOCAL_URL"] ?? "")/\(endPoint)", method: method, parameters: params, encoding: encoding)
//        }else{
//            requset =
//        }
//        
        AF.request("http://\(Bundle.main.infoDictionary?["LOCAL_URL"] ?? "")/\(endPoint)", method: method, parameters: params, encoding: encoding)
            .publishDecodable(type: T.self)
            .value()
            .eraseToAnyPublisher()
            .sink(receiveCompletion: ({ completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    print(completion)
                }
            }), receiveValue: save)
            .store(in: &cancelable)
        
    }
}



