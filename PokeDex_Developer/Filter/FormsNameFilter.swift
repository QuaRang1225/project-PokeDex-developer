//
//  FormsNameFilter.swift
//  PokeDex_Developer
//
//  Created by 유영웅 on 3/27/24.
//

import Foundation

enum FormsNameFilter:String{
    case wormadam           //도롱마담
    case giratina           //기라티나
    
    
    static func compareFormsName(name:String) -> String{
        switch name{
        case FormsNameFilter.wormadam.rawValue : return "wormadam-plant"
        case FormsNameFilter.giratina.rawValue : return "giratina-altered"
        default : return name
        }
    }
}
