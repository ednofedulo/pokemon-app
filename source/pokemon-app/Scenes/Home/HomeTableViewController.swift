//
//  HomeTableViewController.swift
//  pokemon-app
//
//  Created by Edno Fedulo on 26/12/20.
//

import UIKit

protocol HomeViewDelegate:AnyObject {
    func reloadData()
    func showError(error:String)
}

class HomeTableViewController: UITableViewController {
    
    var presenter:HomePresenter?
    
    init(presenter:HomePresenter) {
        self.presenter = presenter
        super.init(style: .plain)
        self.presenter?.fetchPokemons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerCell()
        tableView.separatorStyle = .none
        tableView.rowHeight = 145
    }
    
    func registerCell(){
        let nib = UINib(nibName: "PokemonTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "cell")
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.pokemons.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PokemonTableViewCell
        
        if let pokemon = self.presenter?.pokemons[indexPath.row] {
            self.presenter?.getPokemon(name: pokemon.name!, completionHandler: { (pokemon) in
                cell.setup(pokemon: pokemon)
            })
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == self.presenter?.pokemons.count {
            self.presenter?.fetchPokemons()
        }
    }
    
}

extension HomeTableViewController: HomeViewDelegate {
    func reloadData() {
        self.tableView.reloadData()
    }
    
    func showError(error: String) {
        
    }
}
