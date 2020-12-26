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
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.registerCell()
        tableView.separatorStyle = .none
        tableView.rowHeight = 145
        //        tableView.estimatedRowHeight = 133
    }
    
    func registerCell(){
        
        let nib = UINib(nibName: "PokemonTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "cell")
        
    }
    
    //    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return UITableView.automaticDimension
    //    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.presenter?.pokemons.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PokemonTableViewCell
        
        if let pokemon = self.presenter?.pokemons[indexPath.row] {
            //cell.setup(pokemon: pokemon)
            
            self.presenter?.getPokemon(name: pokemon.name!, completionHandler: { (pokemon) in
                //DispatchQueue.main.async {
                cell.setup(pokemon: pokemon)
                //}
                
            })
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == self.presenter?.pokemons.count {
            self.presenter?.fetchPokemons()
        }
    }
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }    
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}


extension HomeTableViewController: HomeViewDelegate {
    func reloadData() {
        self.tableView.reloadData()
    }
    
    func showError(error: String) {
        
    }
    
}
