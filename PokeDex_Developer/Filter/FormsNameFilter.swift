//
//  FormsNameFilter.swift
//  PokeDex_Developer
//
//  Created by 유영웅 on 3/27/24.
//

import Foundation

enum FormsNameFilter:String{
    case wormadam
    
    
    
    static func compareFormsName(name:String) -> String{
        if name == FormsNameFilter.wormadam.rawValue{
            return "wormadam-plant"
        }
        else{
            return name
        }
    }
}
