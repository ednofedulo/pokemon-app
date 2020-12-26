//
//  HomeService.swift
//  pokemon-app
//
//  Created by Edno Fedulo on 26/12/20.
//

import Foundation
import Alamofire

protocol HomeServiceProtocol:AnyObject {
    func fetchPokemons(offset:Int, limit:Int, completionHandler: @escaping(_ homeModel: ResponseModel<PokemonModel>?, _ error: String?) -> Void)
    func searchPokemon(query:String, completionHandler: @escaping(_ homeModel: PokemonModel?, _ error: String?) -> Void)
}

class HomeService:HomeServiceProtocol {
    
    let baseUrl = "https://pokeapi.co/api/v2/pokemon"
    
    func searchPokemon(query: String, completionHandler: @escaping (PokemonModel?, String?) -> Void) {
        let url = "\(baseUrl)/\(query)"
        
        AF.request(url).responseDecodable(of: PokemonModel.self) { response in
            switch response.result {
            case let .success(value):
                completionHandler(value, nil)
            case .failure(_):
                completionHandler(nil, "Erro ao consultar API")
            }
        }
    }
    
    func fetchPokemons(offset: Int, limit: Int, completionHandler: @escaping (ResponseModel<PokemonModel>?, String?) -> Void) {
        let url = "\(baseUrl)?limit=\(limit)&offset=\(offset)"
        
        AF.request(url).responseDecodable(of: ResponseModel<PokemonModel>.self) { response in
            switch response.result {
            case let .success(value):
                completionHandler(value, nil)
            case .failure(_):
                completionHandler(nil, "Erro ao consultar API")
            }
        }
    }
    
}
