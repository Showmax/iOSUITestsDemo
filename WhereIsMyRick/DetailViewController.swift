//
//  DetailViewController.swift
//  WhereIsMyRick
//
//  Created by Denis Bogomolov on 03/08/2018.
//  Copyright © 2018 showmax. All rights reserved.
//

import UIKit
import Nuke

class DetailViewController: UIViewController {

    let character: Character
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    init(of character: Character) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable, message: "Class can not be used in Interface Builder")
    required init?(coder: NSCoder) { fatalError("Class can not be used in Interface Builder") }

    override func viewDidLoad() {
        super.viewDidLoad()
        Nuke.loadImage(with: character.image, into: avatar)
        name.text = character.name
    }

    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }
}
