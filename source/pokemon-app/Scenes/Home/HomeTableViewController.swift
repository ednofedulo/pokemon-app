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
        self.setupTableviewHeader()
        tableView.separatorStyle = .none
        tableView.rowHeight = 145
        self.title = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setupTableviewHeader(){
        let header = HomeHeaderView(title: "Pokédex", subtitle: "Search for Pokémon by name or using the National Pokédex number.", searchPlaceholder: "What Pokémon are you looking for?")
        header.delegate = self
        header.translatesAutoresizingMaskIntoConstraints = false
        
        self.tableView.tableHeaderView = header
        header.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor).isActive = true
        header.widthAnchor.constraint(equalTo: self.tableView.widthAnchor).isActive = true
        header.topAnchor.constraint(equalTo: self.tableView.topAnchor).isActive = true
        
        self.tableView.tableHeaderView?.layoutIfNeeded()
        self.tableView.tableHeaderView = self.tableView.tableHeaderView
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
        if indexPath.row + 1 == self.presenter?.pokemons.count && self.presenter!.pokemons.count > 1 {
            self.presenter?.fetchPokemons()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! PokemonTableViewCell
        
        if let pokemon = cell.pokemon {
            self.presenter?.showDetail(for: pokemon)
        }
    }
}

extension HomeTableViewController: HomeViewDelegate {
    func reloadData() {
        self.tableView.reloadData()
    }
    
    func showError(error: String) {
        let dialog = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(dialog, animated: true, completion: nil)
    }
}

extension HomeTableViewController : HomeHeaderViewDelegate {
    func search(query: String?) {
        
        self.presenter?.searchPokemon(query: query)
    }
}
