//
//  HomeService.swift
//  pokemon-app
//
//  Created by Edno Fedulo on 26/12/20.
//

import Foundation

protocol HomeServiceProtocol:AnyObject {
    func fetchData(from url:String, completionHandler: @escaping(_ homeModel: RequestModel<PokemonModel>?, _ error: String?) -> Void)
}

class HomeService {
    
}
