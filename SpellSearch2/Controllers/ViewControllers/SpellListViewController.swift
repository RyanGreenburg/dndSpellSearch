//
//  SpellListViewController.swift
//  SpellSearch2
//
//  Created by RYAN GREENBURG on 2/7/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import UIKit

class SpellListViewController: UIViewController {
    
    var spells: [Spell] = []
    var filteredSpells: [Spell]?
    let searchController = UISearchController(searchResultsController: nil)
    
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        updateViews()
        configureSearchController()
    }
    
    func updateViews() {
        SpellController.fetchSpells { (spells) in
            self.spells = spells
            self.filteredSpells = spells
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSpellDetailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                if let destinationVC = segue.destination as? SpellDetailViewController {
                    let spellToSend = spells[indexPath.row]
                    destinationVC.spell = spellToSend
                }
            }
        }
    }
}

// MARK: - Data Source
extension SpellListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.isActive == true {
            return filteredSpells!.count
        } else {
            return spells.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "spellCell", for: indexPath)
        
        if let spells = filteredSpells {
            let spell = spells[indexPath.row]
            cell.textLabel?.text = spell.name
        }
        
        return cell
    }
}

extension SpellListViewController: UISearchResultsUpdating {
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            filteredSpells = spells.filter { spell in
                return spell.name.lowercased().contains(searchText.lowercased())
            }
        } else {
            filteredSpells = spells
        }
        tableView.reloadData()
    }
}
