//
//  PokemonType.swift
//  pokemon-app
//
//  Created by Edno Fedulo on 26/12/20.
//

import Foundation
import UIKit

enum PokemonType:String {
    case normal
    case fighting
    case flying
    case poison
    case ground
    case rock
    case bug
    case ghost
    case steel
    case fire
    case water
    case grass
    case electric
    case psychic
    case ice
    case dragon
    case dark
    case fairy
    case unknown
    case shadow
    
    func backgroundColor() -> UIColor {
        switch self {
        case .normal:
            return UIColor(hexString: "#B5B9C4")
        case .fighting:
            return UIColor(hexString: "#EB4971")
        case .flying:
            return UIColor(hexString: "#83A2E3")
        case .poison:
            return UIColor(hexString: "#9F6E97")
        case .ground:
            return UIColor(hexString: "#9F6E97")
        case .rock:
            return UIColor(hexString: "#D4C294")
        case .bug:
            return UIColor(hexString: "#8BD674")
        case .ghost:
            return UIColor(hexString: "#8571BE")
        case .steel:
            return UIColor(hexString: "#4C91B2")
        case .fire:
            return UIColor(hexString: "#FFA756")
        case .water:
            return UIColor(hexString: "#58ABF6")
        case .grass:
            return UIColor(hexString: "#8BBE8A")
        case .electric:
            return UIColor(hexString: "#F2CB55")
        case .psychic:
            return UIColor(hexString: "#FF6568")
        case .ice:
            return UIColor(hexString: "#91D8DF")
        case .dragon:
            return UIColor(hexString: "#7383B9")
        case .dark:
            return UIColor(hexString: "#6F6E78")
        case .fairy:
            return UIColor(hexString: "#EBA8C3")
        case .unknown:
            return .lightGray
        case .shadow:
            return .lightGray
        }
    }
    
    func color() -> UIColor {
        switch self {
        case .normal:
            return UIColor(hexString: "#9DA0AA")
        case .fighting:
            return UIColor(hexString: "#D04164")
        case .flying:
            return UIColor(hexString: "#748FC9")
        case .poison:
            return UIColor(hexString: "#A552CC")
        case .ground:
            return UIColor(hexString: "#DD7748")
        case .rock:
            return UIColor(hexString: "#BAAB82")
        case .bug:
            return UIColor(hexString: "#8CB230")
        case .ghost:
            return UIColor(hexString: "#556AAE")
        case .steel:
            return UIColor(hexString: "#417D9A")
        case .fire:
            return UIColor(hexString: "#FD7D24")
        case .water:
            return UIColor(hexString: "#4A90DA")
        case .grass:
            return UIColor(hexString: "#62B957")
        case .electric:
            return UIColor(hexString: "#EED535")
        case .psychic:
            return UIColor(hexString: "#EA5D60")
        case .ice:
            return UIColor(hexString: "#61CEC0")
        case .dragon:
            return UIColor(hexString: "#0F6AC0")
        case .dark:
            return UIColor(hexString: "#58575F")
        case .fairy:
            return UIColor(hexString: "#ED6EC7")
        case .unknown:
            return .gray
        case .shadow:
            return .gray
        }
    }
}
