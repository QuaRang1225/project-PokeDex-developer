//
//  Response.swift
//  PokeDex_Developer
//
//  Created by 유영웅 on 5/1/24.
//

import Foundation

struct Response: Codable {
    let status: Int
    let data: [Int]
    let message : String
}