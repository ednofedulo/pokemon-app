//
//  PokemonModel.swift
//  pokemon-app
//
//  Created by Edno Fedulo on 26/12/20.
//

import Foundation

struct PokemonModel:Codable {
    let id:Int?
    let name:String?
    let order:Int?
    let types:[TypeModel]?
    let stats:[StatModel]?
    let abilities:[AbilityModel]?
    let sprites:SpriteOutterWrapper?
    
    func mainType() -> PokemonType? {
        if let types = types, let mainType = types.first, let typeName = mainType.type?.name {
            return PokemonType(rawValue: typeName)!
        }
        
        return nil
    }
}

struct SpriteOutterWrapper:Codable{
    let other:SpriteInnerWrapper?
}

struct SpriteInnerWrapper:Codable {
    let official_artwork:SpriteModel?
    
    enum CodingKeys: String, CodingKey {
            case official_artwork = "official-artwork"
        }
}

struct SpriteModel:Codable {
    let front_default:String?
}

struct AbilityModel:Codable {
    let is_hidden:Bool?
    let slot:Int?
    let ability:NamedProperty?
}

struct StatModel:Codable {
    let base_stat:Int?
    let effort:Int?
    let stat:NamedProperty?
}

struct TypeModel:Codable {
    let slot:Int?
    let type:NamedProperty?
}

struct NamedProperty:Codable {
    let name:String?
    let url:String?
}
