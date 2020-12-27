//
//  AppCoordinator.swift
//  pokemon-app
//
//  Created by Edno Fedulo on 27/12/20.
//

import Foundation
import UIKit

protocol CoordinatorProtocol {
    var window: UIWindow { get }
    var navigationController:UINavigationController? { get }
    func start()
}

class AppCoordinator:CoordinatorProtocol {
    
    var window: UIWindow
    var navigationController: UINavigationController?
    
    init(window: UIWindow) {
        self.window = window
        
    }
    
    func start() {
        let presenter = HomePresenter(service: HomeService(), coordinator: self)
        let viewController = HomeTableViewController(presenter: presenter)
        presenter.delegate = viewController
        self.navigationController = UINavigationController(rootViewController: viewController)
        self.window.rootViewController = self.navigationController
    }
    
    func showDetail(pokemon:PokemonModel){
        let presenter = DetailPresenter(pokemon: pokemon)
        let viewController = DetailViewController(presenter: presenter)
        presenter.delegate = viewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
