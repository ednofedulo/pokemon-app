//
//  StatsView.swift
//  pokemon-app
//
//  Created by Edno Fedulo on 27/12/20.
//

import Foundation
import UIKit

class StatsView:UIView {
    
    lazy var mainStackView:UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        return stackView
    }()
    
    lazy var baseStatHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Base Stats"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var pokedexHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Pokédex Data"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var statsStackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        
        return stackView
    }()
    
    lazy var pokedexStackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        
        return stackView
    }()
    
    let stats:[StatModel]!
    let abilities:[AbilityModel]!
    let color:UIColor!
    
    init(stats: [StatModel], abilities: [AbilityModel], color:UIColor) {
        self.stats = stats
        self.abilities = abilities
        self.color = color
        super.init(frame: CGRect.zero)
        
        addSubviews()
        setupConstraints()
        setupView()
    }
    
    func addSubviews(){
        self.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(baseStatHeaderLabel)
        mainStackView.addArrangedSubview(statsStackView)
        mainStackView.addArrangedSubview(pokedexHeaderLabel)
        mainStackView.addArrangedSubview(pokedexStackView)
        
        loadStats()
        loadPokedexData()
    }
    
    func loadStats(){
        for stat in self.stats {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            
            let statNameLabel = UILabel()
            statNameLabel.widthAnchor.constraint(equalToConstant: 130).isActive = true
            statNameLabel.font = UIFont.boldSystemFont(ofSize: 14)
            statNameLabel.text = stat.stat?.name
            let statValueLabel = UILabel()
            statValueLabel.font = UIFont.systemFont(ofSize: 16)
            statValueLabel.textColor = .secondaryLabel
            statValueLabel.text = String(stat.base_stat!)
            
            stackView.addArrangedSubview(statNameLabel)
            stackView.addArrangedSubview(statValueLabel)
            
            statsStackView.addArrangedSubview(stackView)
        }
    }
    
    func loadPokedexData(){
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
        
        let abilitiesTitleLabel = UILabel()
        abilitiesTitleLabel.widthAnchor.constraint(equalToConstant: 130).isActive = true
        abilitiesTitleLabel.text = "Abilities"
        let abilitiesLabel = UILabel()
        abilitiesLabel.textColor = .secondaryLabel
        abilitiesLabel.numberOfLines = 0
        abilitiesLabel.text = abilities.reduce("") { $0 + $1.description+"\n" }
        
        stackView.addArrangedSubview(abilitiesTitleLabel)
        stackView.addArrangedSubview(abilitiesLabel)
        
        pokedexStackView.addArrangedSubview(stackView)
        
        
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 500)
        ])
    }
    
    func setupView(){
        baseStatHeaderLabel.textColor = color
        pokedexHeaderLabel.textColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
