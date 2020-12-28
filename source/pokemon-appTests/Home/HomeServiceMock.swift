//
//  HomeServiceSuccessMock.swift
//  pokemon-appTests
//
//  Created by Edno Fedulo on 28/12/20.
//

import Foundation
@testable import pokemon_app

class HomeServiceMock:HomeServiceProtocol {
    
    var shouldFail:Bool!
    
    init(shouldFail:Bool = false) {
        self.shouldFail = shouldFail
    }
    
    func fetchPokemons(offset: Int, limit: Int, completionHandler: @escaping (ResponseModel<PokemonModel>?, String?) -> Void) {
        
        guard self.shouldFail == false else {
            completionHandler(nil, "error")
            return
        }
        
        var pokemons = [PokemonModel]()
        
        for i in 1...limit {
            pokemons.append(mockPokemon("mocked_pokemon_\(i)"))
        }
        
        let result = ResponseModel(count: limit, next: nil, previous: nil, results: pokemons)
        
        completionHandler(result, nil)
    }
    
    func searchPokemon(query: String, completionHandler: @escaping (PokemonModel?, String?) -> Void) {
        
        guard self.shouldFail == false else {
            completionHandler(nil, "error")
            return
        }
        
        completionHandler(mockPokemon("mocked_pokemon"), nil)
    }
    
    func mockPokemon(_ name:String) -> PokemonModel {
        
        return PokemonModel(id: Int.random(in: 1..<1000), name: name, order: Int.random(in: 1..<1000), types: [TypeModel(slot: 1, type: NamedProperty(name: "electric", url: "https://pokeapi.co/api/v2/type/13/"))], stats: [StatModel(base_stat: Int.random(in: 1..<100), effort: 0, stat: NamedProperty(name: "hp", url: "https://pokeapi.co/api/v2/stat/1/"))], abilities: [AbilityModel(is_hidden: false, slot: 1, ability: NamedProperty(name: "static", url: "https://pokeapi.co/api/v2/ability/9/"))], sprites: SpriteOutterWrapper(other: SpriteInnerWrapper(official_artwork: SpriteModel(front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png"))))
    }
}
