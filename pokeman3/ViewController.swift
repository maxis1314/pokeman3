//
//  ViewController.swift
//  pokeman3
//
//  Created by Daniel on 17/12/17.
//  Copyright © 2017年 daniel. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UISearchBarDelegate {
    
    @IBOutlet weak var collection:UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var inSearchMode = false

    override func viewDidLoad() {
        super.viewDidLoad()

        //let charmander = Pokemon(name: "Daniel", pokedexId: 4)
        collection.dataSource=self
        collection.delegate=self
        searchBar.delegate=self
        
        searchBar.returnKeyType=UIReturnKeyType.done
        
        parsePokemonCSV()
        initAudio()
    }
    
    func initAudio(){
        let path=Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        do{
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string:path)!)
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    func parsePokemonCSV(){
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        do{
            
            let csv=try CSV(contentsOfURL:path!)
            let rows = csv.rows
            
            for row in rows{
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                let poke = Pokemon(name: name, pokedexId: pokeId)
                pokemon.append(poke)
            }
        } catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            //let pokemon = Pokemon(name: "Pokemon", pokedexId: indexPath.row)
            //cell.configureCell(pokemon)
            
            //let poke = pokemon[indexPath.row]
            //cell.configureCell(poke)
            
            let poke: Pokemon!
            if inSearchMode{
                poke=filteredPokemon[indexPath.row]
            }else{
                poke=pokemon[indexPath.row]
            }
            cell.configureCell(poke)
            
            
            
            return cell
        }else{
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode{
            return filteredPokemon.count
        }else{
            return pokemon.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    
    @IBAction func musicBtnPressed(_ sender: UIButton) {
        if musicPlayer.isPlaying{
            musicPlayer.pause()
            sender.alpha=0.2
        }else{
            musicPlayer.play()
            sender.alpha=1.0
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        print("in search Bar")
        
        if searchBar.text == nil || searchBar.text == "" {
            print("1")
            inSearchMode = false
            collection.reloadData()
            view.endEditing(true)
        }else{
            print("2")

            inSearchMode=true
            let lower = searchBar.text!.lowercased()
            
            filteredPokemon=pokemon.filter({$0.name.range(of: lower) != nil})
            
            collection.reloadData()
            
        }
    }


}

