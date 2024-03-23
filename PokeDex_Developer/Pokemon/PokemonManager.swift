//
//  PokemonManager.swift
//  PokeDex_Developer
//
//  Created by 유영웅 on 3/21/24.
//

import Foundation
import PokemonAPI

protocol Pokemon{
    func getAbilites(name:String) async throws -> ([String],[String],[Bool])            //특성/특성설명/숨은 특성인지
    func getKoreanAbilites(ability:String)async throws -> (String,String)               //한글 특성/한글 특성설명
    func getFormsImage(name:String) async throws -> [String]                            //폼 이미지
    func getFormsName(name:String) async throws -> [String]                             //폼 이름
    func getHeight(name:String) async throws -> Double                                  //키
    func getStats(name:String) async throws -> ([String],[Int])                         //스탯
    func getTypes(name:String) async throws -> [String]                                 //타입
    func getWeight(name:String) async throws -> Double                                  //무게
}

class PokemonManager:ObservableObject,Pokemon{

    
    
    func getAbilites(name: String) async throws -> ([String],[String],[Bool]) {
        guard let pokemonAbilites = try await PokemonAPI().pokemonService.fetchPokemon(name).abilities else {return ([],[],[])}
        
        let abilities = pokemonAbilites.compactMap{$0.ability?.name}
        let abilitiesIsHidden = pokemonAbilites.compactMap{$0.isHidden}
        
        var pokemonKoreanAbilites:([String],[String]) = ([],[])
        
        for korean in abilities{
            let abilitesInfo = try await getKoreanAbilites(ability: korean)
            pokemonKoreanAbilites.0.append(abilitesInfo.0)
            pokemonKoreanAbilites.1.append(abilitesInfo.1)
        }
        
        return (pokemonKoreanAbilites.0,pokemonKoreanAbilites.1,abilitiesIsHidden)
    }
    
    func getKoreanAbilites(ability:String)async throws -> (String,String){
        let pokemonKoreanAbilites = try await PokemonAPI().pokemonService.fetchAbility(ability)
        
        let koreanName = pokemonKoreanAbilites.names?.first(where: {$0.language?.name == "ko"})?.name ?? ""
        let koreanText = pokemonKoreanAbilites.flavorTextEntries?.first(where: {$0.language?.name == "ko"})?.flavorText ?? ""
        
        return (koreanName,koreanText)
    }
    
    func getFormsImage(name:String) async throws -> [String]{
        let pokemon = try await PokemonAPI().pokemonService.fetchPokemon(name)
        
        let forms = pokemon.forms?.compactMap{$0.name} ?? []        //폼 이름 수집
        guard let isDefault = pokemon.isDefault else {return [] }      //디폴트 모습인지 아닌지를 판단하여 이미지 저장 로직 변경
        guard let id = pokemon.id else {return []}                     //id
        
        var formInfo:[String] = []  //폼 이름, 이미지 경로
        for form in forms{
            let pokemonForm = try await PokemonAPI().pokemonService.fetchPokemonForm(form)
            
            if isDefault{
                if let name = pokemonForm.formName{
                    if name.isEmpty{
                        formInfo.append("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/\(id).png")  //어떠한 모습,폼도 존재하지 않을때
                    }else{
                        formInfo.append("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/\(id)-\(name).png")  //다른 모습이 존재할때
                    }
                }
            }else{
                formInfo.append("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/\(id).png")  //다른 폼이 존재할 때
            }
        }
        return formInfo
    }
    func getFormsName(name:String) async throws -> [String]{
        let pokemon = try await PokemonAPI().pokemonService.fetchPokemon(name)
        
        let forms = pokemon.forms?.compactMap{$0.name} ?? []        //폼 이름 수집          
        
        var formInfo:[String] = []  //폼 이름, 이미지 경로
        for form in forms{
            let pokemonForm = try await PokemonAPI().pokemonService.fetchPokemonForm(form)
            
            
            if let name = pokemonForm.formNames?.first(where: {$0.language?.name == "ko"})?.name{   //한글 폼이름이 있는 경우
                formInfo.append(name)
            }
            else if let name = pokemonForm.formName{       //한글 폼이름이 없는 경우(영문은 존재)
                formInfo.append(FormsFilter(rawValue: name)?.translatedName ?? "\(name)")
            }else{
                formInfo.append("")           //폼이름 자체가 존재하지 않는경우
            }
        }
        return formInfo
    }
    func getHeight(name:String) async throws -> Double{
        guard let height = try await PokemonAPI().pokemonService.fetchPokemon(name).height else { return 0 }
        return Double(height) / 10
    }
    func getStats(name:String) async throws -> ([String],[Int]){
        guard let stats = try await PokemonAPI().pokemonService.fetchPokemon(name).stats else {return ([],[])}
        return (stats.compactMap{StatFilter(rawValue: $0.stat?.name ?? "")?.name},stats.compactMap{$0.baseStat})
    }
    
    func getTypes(name:String) async throws -> [String]{
        guard let types = try await PokemonAPI().pokemonService.fetchPokemon(name).types else {return ([])}
        return types.compactMap{TypeFilter(rawValue: $0.type?.name ?? "")?.name}
    }
    
    func getWeight(name:String) async throws -> Double{
        guard let weight = try await PokemonAPI().pokemonService.fetchPokemon(name).weight else { return 0 }
        return Double(weight) / 10
    }
    
}
