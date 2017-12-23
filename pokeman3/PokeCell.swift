//
//  PokeCell.swift
//  pokeman3
//
//  Created by Daniel on 17/12/23.
//  Copyright © 2017年 daniel. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder:NSCoder){
        super.init(coder: aDecoder)
        layer.cornerRadius=5.0
    }
    
    func configureCell(_ pokemon:Pokemon){
        self.pokemon=pokemon
        nameLbl.text=self.pokemon.name.capitalized
        thumbImg.image=UIImage(named: "\(self.pokemon.pokedexId)")
    }
}
