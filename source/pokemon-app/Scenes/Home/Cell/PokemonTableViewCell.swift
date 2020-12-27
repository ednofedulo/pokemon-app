//
//  PokemonTableViewCell.swift
//  pokemon-app
//
//  Created by Edno Fedulo on 26/12/20.
//

import UIKit
import Kingfisher
class PokemonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var coloredBackgroundVIew: UIView!
    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typesStackView: UIStackView!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var pokemon:PokemonModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func setup(pokemon: PokemonModel){
        self.pokemon = pokemon
        
        nameLabel.text = pokemon.name
        orderLabel.text = "#\(String(format: "%04d", pokemon.id ?? 0))"
        
        if let sprites = pokemon.sprites, let other = sprites.other, let artwork = other.official_artwork, let url = URL(string: artwork.front_default ?? "") {
            avatarImageView.kf.setImage(with: url)
        }
        
        if let types = pokemon.types, types.count > 0 {
            self.typesStackView.arrangedSubviews.forEach{
                $0.removeFromSuperview()
            }
            let mainType = pokemon.mainType()
            self.coloredBackgroundVIew.backgroundColor = mainType?.backgroundColor()
            for type in types {
                let badge = UIImageView(image: UIImage(named: "\(type.type!.name!)-badge"))
                badge.contentMode = .scaleAspectFit
                badge.widthAnchor.constraint(equalToConstant: 50).isActive = true
                self.typesStackView.addArrangedSubview(badge)
            }
        }
        
        setupShadow()
    }
    
    private func setupShadow(){
        
        self.coloredBackgroundVIew.layer.shadowColor = self.coloredBackgroundVIew.backgroundColor?.cgColor
        self.coloredBackgroundVIew.layer.shadowOpacity = 0.7
        self.coloredBackgroundVIew.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.coloredBackgroundVIew.layer.shadowRadius = 4
        self.coloredBackgroundVIew.layer.shouldRasterize = true
        self.coloredBackgroundVIew.layer.rasterizationScale = UIScreen.main.scale
        
    }
    
}
