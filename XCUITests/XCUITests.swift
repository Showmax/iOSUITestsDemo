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

import XCTest

class XCUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
    }

    func test__emptyState() {
        // Act: I try to search for 'MoCk'
        app.searchFields.firstMatch.tap()
        app.typeText("MoCk")

        // Assert: I expect to see no results notice
        let exists = app.otherElements[Accessibility.noResultsNotice].waitForExistence(timeout: 10)
        XCTAssert(exists)
    }

    func test__happyPath() {
        // Act: Search for 'Pickle' and tap on first result
        app.searchFields.firstMatch.tap()
        app.typeText("Pickle")
        app.collectionViews[Accessibility.searchResultsList].cells.firstMatch.tap()

        // Assert: I expect to be on 'Pickle Rick' detail screen
        let name = app.staticTexts.element(matching: .any, identifier: Accessibility.characterName)
        let exists = name.waitForExistence(timeout: 10)
        let hasRightName = name.label == "Pickle Rick"
        XCTAssert(exists && hasRightName)
    }
}
