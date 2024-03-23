//
//  FormsFilter.swift
//  PokeDex_Developer
//
//  Created by 유영웅 on 3/22/24.
//

import Foundation

enum FormsFilter: String,CaseIterable {
    case rockStar = "rock-star"
    case starter = "starter"
    case belle = "belle"
    case popStar = "pop-star"
    case phd = "phd"
    case libre = "libre"
    case cosplay = "cosplay"
    case gmax = "gmax"
    case hisui = "hisui"
    case totem = "totem"
    case paldea = "paldea"
    case origin = "origin"
    case whiteStriped = "white-striped"
    case female = "female"
    case male = "male"
    case incarnate = "incarnate"
    case therian = "therian"
    case paldeaCombatBreed = "paldea-combat-breed"
    case paldeaBlazeBreed = "paldea-blaze-breed"
    case paldeaAquaBreed = "paldea-aqua-breed"
    case twoSegment = "two-segment"
    case threeSegment = "three-segment"
    case zero = "zero"
    case hero = "hero"
    case familyOfFour = "family-of-four"
    case familyOfThree = "family-of-three"
    case curly = "curly"
    case droopy = "droopy"
    case stretchy = "stretchy"
    case bluePlumage = "blue-plumage"
    case yellowPlumage = "yellow-plumage"
    case whitePlumage = "white-plumage"
    case greenPlumage = "green-plumage"
    case chest = "chest"
    case roaming = "roaming"
    case battleBond = "battle-bond"
    case totemAlola = "totem-alola"

    var translatedName: String {
        switch self {
        case .rockStar:
            return "하드록"
        case .starter:
            return "스타터"
        case .belle:
            return "마담"
        case .popStar:
            return "아이돌"
        case .phd:
            return "닥터"
        case .libre:
            return "마스크드"
        case .cosplay:
            return "코스튬플레이"
        case .gmax:
            return "거다이맥스"
        case .hisui:
            return "히스이"
        case .totem:
            return "우두머리"
        case .paldea:
            return "팔데아"
        case .origin:
            return "오리진폼"
        case .whiteStriped:
            return "백색근의 모습"
        case .female:
            return "암컷의 모습"
        case .male:
            return "수컷의 모습"
        case .incarnate:
            return "화신폼"
        case .therian:
            return "영물폼"
        case .paldeaCombatBreed:
            return "팔데아 컴뱃"
        case .paldeaBlazeBreed:
            return "팔데아 블레이즈"
        case .paldeaAquaBreed:
            return "팔데아 워터"
        case .twoSegment:
            return "두마디폼"
        case .threeSegment:
            return "세마디폼"
        case .zero:
            return "나이브폼"
        case .hero:
            return "마이티폼"
        case .familyOfFour:
            return "네식구"
        case .familyOfThree:
            return "세식구"
        case .curly:
            return "젖힌모습"
        case .droopy:
            return "늘어진모습"
        case .stretchy:
            return "뻗은모습"
        case .bluePlumage:
            return "파랑깃털"
        case .yellowPlumage:
            return "노랑깃털"
        case .whitePlumage:
            return "하얀깃털"
        case .greenPlumage:
            return "초록깃털"
        case .chest:
            return "상자폼"
        case .roaming:
            return "도보폼"
        case .battleBond:
            return "유대변화"
        case .totemAlola:
            return "알로라의 우두머리"
        }
    }
}
