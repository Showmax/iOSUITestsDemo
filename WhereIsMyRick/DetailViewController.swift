// Copyright since 2015 Showmax s.r.o.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

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
