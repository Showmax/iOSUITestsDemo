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

@testable import WhereIsMyRick

import XCTest
import FBSnapshotTestCase

class  📸: XCTestCase {

    private var snapshoter: Snapshoter!

    override func setUp() {
        super.setUp()
        snapshoter = Snapshoter(self)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func test__ViewControllerState__NothingLoadedYet() {
        let vc = createViewController(with: .empty)
        snapshoter.checkSnapshot(of: vc.view)
    }

    func test__ViewControllerState__Error() {
        let err = NSError(domain: "Hello Error", code: 37, userInfo: ["String": "Any"])
        let vc = createViewController(with: .error(err))
        snapshoter.checkSnapshot(of: vc.view)
    }

    func test__ViewControllerState__LoadedCharacters() {

        let text = "Pulp fiction"
//        let character = WhereIsMyRick.Character(
//            name: "Rick Sanchez",
//            image: URL(string: "https://rickandmortyapi.com/api/character/avatar/159.jpeg")!
//        )
//

//        snapshoter.checkSnapshot(of: vc.view)
    }
}

private extension 📸 {

    func createViewController(with state: ViewController.State) -> ViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! ViewController
        vc.view.layoutSubviews()
        vc.translate(to: state)
        return vc
    }
}
