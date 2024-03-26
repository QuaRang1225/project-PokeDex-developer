//
//  Pokemon.swift
//  PokeDex_Developer
//
//  Created by 유영웅 on 3/23/24.
//

import Foundation

protocol Pokemon{
    func getAbilites(name:String) async throws -> ([String],[String],[Bool])            //특성/특성설명/숨은 특성인지
    func getFormsImage(name:String,getOnlyForms:Bool) async throws -> [String]          //폼 이미지
    func getFormsName(name:String) async throws -> [String]                             //폼 이름
    func getHeight(name:String) async throws -> Double                                  //키
    func getStats(name:String) async throws -> ([String],[Int])                         //스탯
    func getTypes(name:String) async throws -> [String]                                 //타입
    func getWeight(name:String) async throws -> Double                                  //무게
}
