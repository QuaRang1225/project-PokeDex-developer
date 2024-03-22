//
//  StatFilter.swift
//  PokeDex_Developer
//
//  Created by 유영웅 on 3/22/24.
//

import Foundation

enum StatFilter:String,CaseIterable{
    case hp = "hp"
    case attack = "attack"
    case defense = "defense"
    case sepcilAttack = "special-attack"
    case specialDefense = "special-defense"
    case speed = "speed"
    
    var name:String{
        switch self{
        case .hp:
            return "HP"
        case .attack:
            return "공격"
        case .defense:
            return "방어"
        case .sepcilAttack:
            return "특공"
        case .specialDefense:
            return "특방"
        case .speed:
            return "스피드"
        }
    }
}
