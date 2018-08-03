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

    /// On search screen
    /// I try to search for 'MoCk'
    /// I expect to see no results notice
    func test__emptyState() { }

    /// On search screen
    /// I try to search for 'Pickle'
    /// I try to tap on first result
    /// I expect to be on 'Pickle Rick' detail screen
    func test__happyPath() { }
}
