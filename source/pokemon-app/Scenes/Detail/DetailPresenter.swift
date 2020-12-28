//
//  DetailPresenter.swift
//  pokemon-app
//
//  Created by Edno Fedulo on 26/12/20.
//

import Foundation

class DetailPresenter {
    
    weak var delegate:DetailViewDelegate? {
        didSet {
            self.delegate?.setupView(pokemon: self.pokemon!)
        }
    }
    
    let pokemon:PokemonModel?
    
    init(pokemon:PokemonModel) {
        self.pokemon = pokemon
    }
}
