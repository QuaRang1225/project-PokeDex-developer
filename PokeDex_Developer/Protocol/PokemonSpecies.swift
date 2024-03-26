//
//  PokemonSpecies.swift
//  PokeDex_Developer
//
//  Created by 유영웅 on 3/21/24.
//

import Foundation

protocol PokemonSpecies{
    func getEggGroups(num:Int) async throws -> [String]                         //알그룹
    func getTextEntried(num:Int) async throws -> ([String],[String])            //도감 설명
    func getFormsSwitchable(num:Int) async throws -> Bool                       //폼체인지 유무
    func getGenderRate(num:Int) async throws -> Int                             //성비
    func getGenra(num:Int) async throws -> String                               //분류
    func getHatchCounter(num:Int) async throws -> Int                           //부화 카운트
    func getName(num:Int) async throws -> String                                //이름 - 번호로 검색
    func getName(name:String) async throws -> String                            //이름 - 이름으로 검색
    func getPokdexNumbers(num:Int) async throws -> ([String],[Int])             //도감 번호 및 도감 지역
    func getVarieties(num:Int) async throws -> [String]                         //리전폼 - 번호로 검색
    func getVarieties(name:String) async throws -> [String]                     //리전폼 - 이름으열 검색
    
}
