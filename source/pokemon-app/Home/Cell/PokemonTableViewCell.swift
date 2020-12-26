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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
    }
        
    func setup(pokemon: PokemonModel){
        nameLabel.text = pokemon.name
        orderLabel.text = "#\(String(format: "%04d", pokemon.id ?? 0))"
        
        if let sprites = pokemon.sprites, let other = sprites.other, let artwork = other.official_artwork, let url = URL(string: artwork.front_default ?? "") {
            avatarImageView.kf.setImage(with: url)
        }
        
        if let types = pokemon.types, types.count > 0 {
            self.typesStackView.arrangedSubviews.forEach{
                $0.removeFromSuperview()
            }
            let mainType = PokemonType(rawValue: types.first!.type!.name!)
            self.coloredBackgroundVIew.backgroundColor = mainType?.backgroundColor()
            for type in types {
                let badge = UIImageView(image: UIImage(named: "\(type.type!.name!)-badge"))
                badge.contentMode = .scaleAspectFit
                badge.widthAnchor.constraint(equalToConstant: 50).isActive = true
                self.typesStackView.addArrangedSubview(badge)
            }
        }
    }
    
}
