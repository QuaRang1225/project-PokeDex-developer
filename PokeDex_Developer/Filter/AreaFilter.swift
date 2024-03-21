//
//  AreaFilter.swift
//  PokeDex_Developer
//
//  Created by 유영웅 on 3/21/24.
//

import Foundation

enum AreaFilter: String,CaseIterable {
    case national = "national"
    case kanto = "kanto"
    case originalJohto = "original-johto"
    case hoenn = "hoenn"
    case originalSinnoh = "original-sinnoh"
    case extendedSinnoh = "extended-sinnoh"
    case updatedJohto = "updated-johto"
    case originalUnova = "original-unova"
    case updatedUnova = "updated-unova"
    case conquestGallery = "conquest-gallery"
    case kalosCentral = "kalos-central"
    case kalosCoastal = "kalos-coastal"
    case kalosMountain = "kalos-mountain"
    case updatedHoenn = "updated-hoenn"
    case originalAlola = "original-alola"
    case originalMelemele = "original-melemele"
    case originalAkala = "original-akala"
    case originalUlaula = "original-ulaula"
    case originalPoni = "original-poni"
    case updatedAlola = "updated-alola"
    case updatedMelemele = "updated-melemele"
    case updatedAkala = "updated-akala"
    case updatedUlaula = "updated-ulaula"
    case updatedPoni = "updated-poni"
    case letsgoKanto = "letsgo-kanto"
    case galar = "galar"
    case isleOfArmor = "isle-of-armor"
    case crownTundra = "crown-tundra"
    case hisui = "hisui"
    case paldea = "paldea"
    case kitakami = "kitakami"
    case blueberry = "blueberry"
    
    var name: String {
        switch self {
            case .national: return "전국"
            case .kanto: return "관동"
            case .originalJohto: return "성도(구)"
            case .hoenn: return "호연(구)"
            case .originalSinnoh: return "신오(구)"
            case .extendedSinnoh: return "신오(신)"
            case .updatedJohto: return "성도(신)"
            case .originalUnova: return "하나(구)"
            case .updatedUnova: return "하나(신)"
            case .conquestGallery: return "컨퀘스트"
            case .kalosCentral: return "칼로스 센트럴"
            case .kalosCoastal: return "칼로스 코스트"
            case .kalosMountain: return "칼로스 마운틴"
            case .updatedHoenn: return "호연(신)"
            case .originalAlola: return "알로라(구)"
            case .originalMelemele: return "멜레멜레 삼(구)"
            case .originalAkala: return "아칼라 섬(구)"
            case .originalUlaula: return "울라울라 섬(구)"
            case .originalPoni: return "포니 섬(구)"
            case .updatedAlola: return "알로라(신)"
            case .updatedMelemele: return "멜레멜레 섬(신)"
            case .updatedAkala: return "아칼라 섬(신)"
            case .updatedUlaula: return "울라울라 섬(신)"
            case .updatedPoni: return "포니 섬(신)"
            case .letsgoKanto: return "레츠고"
            case .galar: return "가라르"
            case .isleOfArmor: return "갑옷의 외딴섬"
            case .crownTundra: return "왕관의 설원"
            case .hisui: return "히스이"
            case .paldea: return "팔데아"
            case .kitakami: return "북신의 고장"
            case .blueberry: return "블루베리 아카데미"
        }
    }
}

