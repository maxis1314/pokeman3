//
//  Pokemon.swift
//  pokeman3
//
//  Created by Daniel on 17/12/17.
//  Copyright © 2017年 daniel. All rights reserved.
//

import Foundation

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    
    var name: String{
        return _name

    }
    
    var pokedexId: Int{
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int){
        self._name = name
        self._pokedexId = pokedexId
    }
}
