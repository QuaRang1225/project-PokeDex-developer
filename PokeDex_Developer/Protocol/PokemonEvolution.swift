//
//  PokemonEvolution.swift
//  PokeDex_Developer
//
//  Created by 유영웅 on 3/26/24.
//

import Foundation

protocol PokemonEvolution{
    func getEvolutionChainUrl(num:Int) async throws -> Int          //포켓몬 진화트리 요청 번호
    func getEvolutionChain(num:Int) async throws -> EvolutionTo
}
