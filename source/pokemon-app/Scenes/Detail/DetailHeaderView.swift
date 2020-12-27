//
//  DetailHeaderView.swift
//  pokemon-app
//
//  Created by Edno Fedulo on 27/12/20.
//

import UIKit

enum DetailHeaderViewState {
    case shrinked
    case expanded
}

class DetailHeaderView: UIView {
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 110).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 110).isActive = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var numberLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor.black.withAlphaComponent(0.7)
        return label
    }()
    
    lazy var nameLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textColor = .white
        return label
    }()
    
    lazy var typesStackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        return stackView
    }()
    
    let pokemon:PokemonModel?
    
    var expandedConstraints:[NSLayoutConstraint]?
    var shrinkedConstraints:[NSLayoutConstraint]?
    
    init(pokemon:PokemonModel) {
        self.pokemon = pokemon
        super.init(frame: CGRect.zero)
        
        addSubviews()
        setupConstraints(.expanded)
        setupView()
    }
    
    private func addSubviews(){
        self.addSubview(avatarImageView)
        self.addSubview(numberLabel)
        self.addSubview(nameLabel)
        self.addSubview(typesStackView)
    }
    
    func setupConstraints(_ state:DetailHeaderViewState){
        switch state {
        case .expanded:
            loadExpandedConstraints()
        case .shrinked:
            loadShrinkedConstraints()
        }
    }
    
    func loadExpandedConstraints(){
        
        if expandedConstraints == nil {
            expandedConstraints = [
                avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                avatarImageView.topAnchor.constraint(equalTo: self.topAnchor),
                self.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
                numberLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: 10),
                numberLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
                nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
                nameLabel.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 5),
                typesStackView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
                typesStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
                self.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 30)
            ]
        }
        
        if let shrinkedConstraints = self.shrinkedConstraints {
            NSLayoutConstraint.deactivate(shrinkedConstraints)
        }
        
        NSLayoutConstraint.activate(expandedConstraints!)
        
        UIView.animate(withDuration: 0.1) {
            self.avatarImageView.alpha = 1
            self.numberLabel.alpha = 1
            self.typesStackView.alpha = 1
        }
    }
    
    func loadShrinkedConstraints(){
        
        if shrinkedConstraints == nil {
            shrinkedConstraints = [
                nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                self.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)
            ]
        }
        
        if let expandedConstraints = self.expandedConstraints {
            NSLayoutConstraint.deactivate(expandedConstraints)
        }
        
        NSLayoutConstraint.activate(shrinkedConstraints!)
        
        UIView.animate(withDuration: 0.1) {
            self.avatarImageView.alpha = 0
            self.numberLabel.alpha = 0
            self.typesStackView.alpha = 0
        }
    
    }
    
    private func setupView(){
        
        if let sprites = self.pokemon?.sprites, let other = sprites.other, let artwork = other.official_artwork, let url = URL(string: artwork.front_default ?? "") {
            avatarImageView.kf.setImage(with: url)
        }
        
        self.nameLabel.text = self.pokemon?.name?.capitalized
        self.numberLabel.text = "#\(String(format: "%04d", self.pokemon?.id ?? 0))"
        
        if let types = self.pokemon?.types, types.count > 0 {
            for type in types {
                let image = UIImage(named: "\(type.type!.name!)-badge")!
                let badge = UIImageView(image: image)
                badge.contentMode = .scaleAspectFit
                badge.widthAnchor.constraint(equalToConstant: 25 * (image.size.width / image.size.height)).isActive = true
                self.typesStackView.addArrangedSubview(badge)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
