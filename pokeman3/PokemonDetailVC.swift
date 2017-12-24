//
//  PokemonDetailVC.swift
//  pokeman3
//
//  Created by Daniel on 17/12/24.
//  Copyright © 2017年 daniel. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon:Pokemon!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = pokemon.name

    }



}
