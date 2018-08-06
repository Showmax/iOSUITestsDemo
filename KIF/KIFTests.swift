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
import KIF
import XCTest
@testable import WhereIsMyRick

class KIFTests: XCTestCase {

    override class func setUp() {
        KIFEnableAccessibility()
    }

    override func setUp() {
        super.setUp()
        AppDelegate.restartApp()
    }

    func test__emptyState() {
        // Act: I try to search for 'Aaaa'
        tester().enterText("Aaaa", intoViewWithAccessibilityLabel: nil, traits: .searchField, expectedResult: nil)

        // Assert: I expect to see no results notice
        let noResults = tester().waitForView(withAccessibilityLabel: Accessibility.noResultsNotice)
        XCTAssertNotNil(noResults)
    }

    func test__happyPath() {
        // Act: Search for 'Ant-Man and' and tap on first result
        tester().enterText("Ant-Man and", intoViewWithAccessibilityLabel: nil, traits: .searchField, expectedResult: nil)
        let results = tester().waitForView(withAccessibilityIdentifier: Accessibility.searchResultsList) as? UICollectionView
        tester().tapItem(at: IndexPath(item: 0, section: 0), in: results)

        // Assert: I expect to be on 'Ant-Man and the Wasp' detail screen
        let title = tester().waitForView(withAccessibilityIdentifier: Accessibility.movieTitle) as? UILabel
        XCTAssert(title?.text == "Ant-Man and the Wasp")
    }
}
