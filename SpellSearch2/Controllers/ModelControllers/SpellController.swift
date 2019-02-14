//
//  SpellController.swift
//  SpellSearch2
//
//  Created by RYAN GREENBURG on 2/7/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import Foundation

class SpellController {
    
    static let baseUrl = URL(string: "http://www.dnd5eapi.co/api/spells/")
    
    static func fetchSpells(completion: @escaping ([Spell]) -> Void) {
        guard let url = baseUrl else { completion([]); return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let downloadError = error {
                print("Error downloading spells from api \(downloadError.localizedDescription)")
                completion([])
                return
            }
            guard let data = data else { completion ([]); return }
            
            do {
                let decoder = JSONDecoder()
                let spellDictionary = try decoder.decode(Spells.self, from: data)
                let spells = spellDictionary.results
                completion(spells)
                
            } catch {
                print("Error decoding spells from web \(error.localizedDescription)")
                completion([])
            }
        }
        dataTask.resume()
    }
    
    static func fetchSpellNamed(spell: Spell, completion: @escaping (SpellDetail?) -> Void) {
        guard let url = URL(string: spell.url) else { completion(nil); return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let downloadError = error {
                print("Error downloading spells from api \(downloadError.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else { completion(nil); return }
            
            do {
                let decoder = JSONDecoder()
                let spell = try decoder.decode(SpellDetail.self, from: data)
                completion(spell)
                
            } catch {
                print("Error decoding spell from web \(error.localizedDescription)")
                return
            }
        }
        dataTask.resume()
    }
}
