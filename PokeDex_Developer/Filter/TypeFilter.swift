//
//  typeFilter.swift
//  PokeDex_Developer
//
//  Created by 유영웅 on 3/23/24.
//

import Foundation

enum TypeFilter: String {
    case bug = "bug"
    case normal = "normal"
    case fairy = "fairy"
    case dark = "dark"
    case flying = "flying"
    case dragon = "dragon"
    case electric = "electric"
    case fighting = "fighting"
    case fire = "fire"
    case ghost = "ghost"
    case grass = "grass"
    case ground = "ground"
    case ice = "ice"
    case poison = "poison"
    case psychic = "psychic"
    case rock = "rock"
    case steel = "steel"
    case water = "water"
    case unknown = "unknown"
    
    var name: String {
        switch self {
        case .bug: return "벌레"
        case .normal: return "노말"
        case .fairy: return "페어리"
        case .dark: return "악"
        case .flying: return "비행"
        case .dragon: return "드래곤"
        case .electric: return "전기"
        case .fighting: return "격투"
        case .fire: return "불꽃"
        case .ghost: return "고스트"
        case .grass: return "풀"
        case .ground: return "땅"
        case .ice: return "얼음"
        case .poison: return "독"
        case .psychic: return "에스퍼"
        case .rock: return "바위"
        case .steel: return "강철"
        case .water: return "물"
        case .unknown: return "???"
        }
    }
}


