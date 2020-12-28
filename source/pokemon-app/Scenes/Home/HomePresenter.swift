//
//  HomePresenter.swift
//  pokemon-app
//
//  Created by Edno Fedulo on 26/12/20.
//

import Foundation

class HomePresenter {
    
    weak var coordinator:AppCoordinator?
    weak var delegate:HomeViewDelegate?
    var service:HomeServiceProtocol?
    
    var pokemons:[PokemonModel] = [PokemonModel]()
    
    let screenTitle = "Pokédex"
    
    init(service:HomeServiceProtocol, coordinator:AppCoordinator?) {
        self.service = service
        self.coordinator = coordinator
    }
    
    func fetchPokemons(){
        service?.fetchPokemons(offset: pokemons.count, limit: 10) { (resp, error) in
            guard error == nil else {
                self.delegate?.showError(error: error!)
                return
            }
            
            guard let resp = resp, let pokemons = resp.results else { return }
            self.pokemons.append(contentsOf: pokemons)
            self.delegate?.reloadData()
        }
    }
    
    func getPokemon(name:String, completionHandler: @escaping (PokemonModel) -> Void){
        service?.searchPokemon(query: name, completionHandler: { (resp, error) in
            guard error == nil else {
                self.delegate?.showError(error: error!)
                return
            }
            
            guard let pokemon = resp else { return }
            
            completionHandler(pokemon)
        })
    }
    
    func searchPokemon(query:String?) {
        
        if query == nil || query!.isEmpty {
            self.pokemons = [PokemonModel]()
            self.fetchPokemons()
            return
        }
        
        service?.searchPokemon(query: query!.lowercased(), completionHandler: { (resp, error) in
            guard error == nil else {
                self.delegate?.showError(error: error!)
                return
            }
            
            guard let pokemon = resp else { return }
            self.pokemons = [pokemon]
            self.delegate?.reloadData()
        })
    }
    
    func showDetail(for pokemon:PokemonModel) {
        self.coordinator?.showDetail(pokemon: pokemon)
    }
}
