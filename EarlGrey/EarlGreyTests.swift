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

import Foundation
import XCTest
@testable import WhereIsMyRick

class EarlGreyTests: XCTestCase {

    override func setUp() {
        super.setUp()
        AppDelegate.restartApp()
    }

    func test__emptyState() {
        // Act: I try to search for 'MoCk'
        EarlGrey
            .selectElement(with: .accessibilityTrait(.searchField))
            .perform(.type(text: "MoCk"))

        // Assert: I expect to see no results notice
        EarlGrey
            .selectElement(with: .accessibilityLabel(Accessibility.noResultsNotice))
            .assert(.notNil)
    }

    func test__happyPath() {
        // Act: Search for 'Pickle' and tap on first result
        EarlGrey
            .selectElement(with: .accessibilityTrait(.searchField))
            .perform(.type(text: "Pickle"))

        let resultCell: Matcher = .all([
            .ancestor(.accessibilityID(Accessibility.searchResultsList)),
            .kindOfClass(UICollectionViewCell.self)
            ])
        EarlGrey
            .selectElement(with: resultCell)
            .atIndex(0)
            .perform(.tap())

        // Assert: I expect to be on 'Pickle Rick' detail screen
        EarlGrey
            .selectElement(with: .accessibilityID(Accessibility.characterName))
            .assert(.notNil)
            .assert(.text("Pickle Rick"))
    }
}
