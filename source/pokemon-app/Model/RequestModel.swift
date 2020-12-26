//
//  RequestModel.swift
//  pokemon-app
//
//  Created by Edno Fedulo on 26/12/20.
//

import Foundation

struct RequestModel<T:Codable>:Codable {
    let count:Int?
    let next:String?
    let previous:String?
    let results:T?
}
