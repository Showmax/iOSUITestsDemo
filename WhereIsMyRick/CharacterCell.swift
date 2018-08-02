//
//  CharacterCell.swift
//  WhereIsMyRick
//
//  Created by Denis Bogomolov on 02/08/2018.
//  Copyright © 2018 showmax. All rights reserved.
//

import UIKit
import Nuke

class CharacterCell: UICollectionViewCell {
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    func setup(with character: Character) {
        name.text = character.name
        Nuke.loadImage(with: character.image, into: avatar)
    }
}
