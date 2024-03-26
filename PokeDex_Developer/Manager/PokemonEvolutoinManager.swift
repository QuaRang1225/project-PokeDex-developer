//
//  PokeminEvolutoinManager.swift
//  PokeDex_Developer
//
//  Created by 유영웅 on 3/23/24.
//

import Foundation
import PokemonAPI


class PokemonEvolutoinManager:ObservableObject{
    
    let manager = PokemonManager()
    let speciesmManager = PokemonSpeciesManager()
    
    func getEvolutionChainUrl(num:Int) async throws -> Int{
        guard let url = try await PokemonAPI().pokemonService.fetchPokemonSpecies(num).evolutionChain?.url else {return 0}
        guard let dexNum = Int(URL(string: url)?.lastPathComponent ?? "") else {return 0}
        
        return dexNum
    }
    
    func getEvolutionChain(num:Int) async throws -> PokemonEvolutionInfo{
        guard let chain = try await PokemonAPI().evolutionService.fetchEvolutionChain(num).chain else {return PokemonEvolutionInfo(image: [], name: "")}
        
        guard let first = chain.species?.name else {return PokemonEvolutionInfo(image: [], name: "")}    //1단계거나 진화형태가 없을 경우 first로 취급 - 포켓몬 영문명 반환
        
        var PokemonSecond:[PokemonEvolutionInfo] = []
        if let secondChains = chain.evolvesTo {  //2단계 포켓몬(마지막일 수 있음) - 포켓몬 영문명 반환
            for secondChain in secondChains{
                var PokemonThird:[PokemonEvolutionInfo] = []
                if let thirdChains = secondChain.evolvesTo {    //3단계 포켓몬 - 포켓몬 영문명 반환
                    for thirdChain in thirdChains{
                        let thirdPokemonName = try await speciesmManager.getName(name: thirdChain.species?.name ?? "")
                        let thirdPokemonImages = try await manager.getFormsImage(name: thirdChain.species?.name ?? "",getOnlyForms: true)
                        PokemonThird.append(PokemonEvolutionInfo(image: thirdPokemonImages, name: thirdPokemonName))
                    }
                }
                let secondPokemonName = try await speciesmManager.getName(name: secondChain.species?.name ?? "")
                let secondPokemonImages = try await manager.getFormsImage(name: secondChain.species?.name ?? "",getOnlyForms: true)
                PokemonSecond.append(PokemonEvolutionInfo(image: secondPokemonImages, name: secondPokemonName,children: PokemonThird))
            }
        }
        let firstPokemonName = try await speciesmManager.getName(name: first)
        let firstPokemonImages = try await manager.getFormsImage(name: first,getOnlyForms: true)
        return PokemonEvolutionInfo(image: firstPokemonImages, name: firstPokemonName,children: PokemonSecond)
        
        
        
    }
}
