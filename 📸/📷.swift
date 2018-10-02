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
import FBSnapshotTestCase


/// Class responsible for making snapshots of views
class Snapshoter {

    static var isRecording: Bool { return ProcessInfo.processInfo.arguments.contains("-record") }

    static var referenceImageDirectory: String? { return ProcessInfo.processInfo.environment["FB_REFERENCE_IMAGE_DIR"] }

    let test: XCTestCase?
    private let envReferenceImageDirectory: String?
    private let snapshotController: FBSnapshotTestController
    private var snapshotCounter: Int = 0

    init(_ test: XCTestCase?) {
        self.test = test
        guard let testClass = test?.testRunClass else { fatalError() }
        snapshotController = FBSnapshotTestController.init(test: testClass)
        snapshotController.recordMode = Snapshoter.isRecording
        snapshotController.agnosticOptions = [.screenSize]

        envReferenceImageDirectory = Snapshoter.referenceImageDirectory
    }

    /// If called in `record` mode, make snapshot of view and store it on disk
    /// If called in `test` mode, make snapshot and compare it to reference image from disk
    func checkSnapshot(of view: UIView, file: StaticString = #file, line: UInt = #line) {
        snapshotCounter += 1
        FBSnapshotVerifyViewOrLayer(view, identifier: "Step\(snapshotCounter)", file: file, line: line)
    }

    // MARK: - iOSSnapshot code
    private func FBSnapshotVerifyViewOrLayer(
        _ view: UIView,
        identifier: String = "",
        tolerance: CGFloat = 0,
        file: StaticString,
        line: UInt
        ) {
        guard let selector = test?.invocation?.selector else {
            XCTFail("Can't find current test selector, are you sure you calling this method from test?")
            return
        }
        guard let envReferenceImageDirectory = self.envReferenceImageDirectory else {
            let msg = "Missing value for referenceImagesDirectory" +
                " - " +
                "Set FB_REFERENCE_IMAGE_DIR as Environment variable in your scheme if you running in simulator" +
            "or make sure that Snapshots.bundle added to target if you running on real device."
            XCTFail(msg)
            return
        }
        snapshotController.referenceImagesDirectory = envReferenceImageDirectory
        do {
            try snapshotController.compareSnapshot(ofViewOrLayer: view, selector: selector, identifier: identifier, tolerance: tolerance)
        } catch let error as NSError {
            if Snapshoter.isRecording {
                print("Save in: \(snapshotController.referenceImagesDirectory ?? "Nowhere?")")
                print("Test ran in record mode. Reference image is now saved. Disable record mode to perform an actual snapshot comparison!")
            }
            XCTFail("❌ Snapshot comparison failed: \(String(describing: error))", file: file, line: line)
        }
    }
}

// MARK: - Checking of window
extension Snapshoter {

    func checkSnapshotOfWindow(file: StaticString = #file, line: UInt = #line) {
        UIApplication.shared.keyWindow.map {
            self.checkSnapshot(of: $0, file: file, line: line)
        }
    }
}
