//
//  SpellDetailViewController.swift
//  SpellSearch2
//
//  Created by RYAN GREENBURG on 2/7/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import UIKit

class SpellDetailViewController: UIViewController {
    
    var spell: Spell?
    
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var schoolLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var castingTimeLabel: UILabel!
    @IBOutlet weak var rangeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var componentsLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }


    func updateViews() {
        guard let spell = spell else { return }
        SpellController.fetchSpellNamed(spell: spell) { (spellDetail) in
            guard let spell = spellDetail else { return }
            DispatchQueue.main.async {
                self.title = spell.name
                self.castingTimeLabel.text = spell.castingTime
                self.rangeLabel.text = spell.range
                self.durationLabel.text = spell.duration
                self.componentsLabel.text = "\(spell.components.joined(separator: " "))"
                self.descriptionLabel.text = "\(spell.description.joined(separator: "\n \n"))"
                self.levelLabel.text = "\(spell.level)"
                self.schoolLabel.text = "\(spell.school)"
                self.sourceLabel.text = spell.page.uppercased()
            }
        }
    }
}
