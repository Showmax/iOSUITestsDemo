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
import EarlGrey

struct ActionFactory {

    fileprivate let factory: () -> GREYAction
    fileprivate init(_ factory: @escaping () -> GREYAction) {
        self.factory = factory
    }

    fileprivate func `do`() -> GREYAction {
        return factory()
    }
}

extension ActionFactory {

    // MARK: - Click / press
    /// Returns an action that taps on an element at the specified @c point. Point that should be tapped must be
    /// in the coordinate system of the element and it's position is relative to the origin of the element, as in
    /// (element_width/2, element_height/2) will tap at the center of element.
    static func tap(point: CGPoint? = nil) -> ActionFactory {
        if let p = point {
            return ActionFactory { grey_tapAtPoint(p) }
        }
        return ActionFactory { grey_tap() }
    }

    /// Returns an action that holds down finger for specified @c duration at the specified @c point
    /// (interpreted as being relative to the element) to simulate a long press.
    static func longPress(point: CGPoint? = nil, duration: TimeInterval = 1.0) -> ActionFactory {
        if let p = point {
            return ActionFactory { grey_longPressAtPointWithDuration(p, duration) }
        }
        return ActionFactory { grey_longPressWithDuration(duration) }
    }

    /// GREYAction that performs @c count taps
    static func multipleTaps(count: UInt) -> ActionFactory {
        return ActionFactory { grey_multipleTapsWithCount(count) }
    }

    // MARK: - Gestures
    /// Returns a scroll action that scrolls in a @c direction for an @c amount of points starting from
    /// the given start point specified as percentages. @c originPercentage.x is the x start
    /// position as a percentage of the total width of the scrollable visible area,
    /// @c originPercentage.y is the y start position as a percentage of the total height of the
    /// scrollable visible area. @c originPercentage must be between in [0;1]x[0;1] exclusive.
    static func scroll(direction: GREYDirection, amount: CGFloat, originPercentage: CGPoint? = nil) -> ActionFactory {
        if let o = originPercentage {
            return ActionFactory { grey_scrollInDirectionWithStartPoint(direction, amount, o.x, o.y) }
        }
        return ActionFactory { grey_scrollInDirection(direction, amount) }
    }

    /// A GREYAction that scrolls to the given content @c edge of a scroll view with the scroll action
    /// starting from the given start point specified as percentages. @c originPercentage.x is the x
    /// start position as a percentage of the total width of the scrollable visible area,
    /// @c originPercentage.y is the y start position as a percentage of the total height of the
    /// scrollable visible area. @c originPercentage must be between in [0;1]x[0;1] exclusive.
    static func scrollTo(edge: GREYContentEdge, originPercentage: CGPoint? = nil) -> ActionFactory {
        if let o = originPercentage {
            return ActionFactory { grey_scrollToContentEdgeWithStartPoint(edge, o.x, o.y) }
        }
        return ActionFactory { grey_scrollToContentEdge(edge) }
    }

    /// Returns an action that swipes through the view quickly in the given @c direction from a specific origin.
    /// If origin not specified, the start point of the swipe is chosen to
    /// achieve the maximum the swipe possible to the other edge.
    static func swipeFast(direction: GREYDirection, originPercentage: CGPoint? = nil) -> ActionFactory {
        if let o = originPercentage {
            return ActionFactory { grey_swipeFastInDirectionWithStartPoint(direction, o.x, o.y) }
        }
        return ActionFactory { grey_swipeFastInDirection(direction) }
    }

    /// Returns an action that swipes through the view quickly in the given @c direction from a specific origin.
    /// If origin not specified, the start point of the swipe is chosen to
    /// achieve the maximum the swipe possible to the other edge.
    static func swipeSlow(direction: GREYDirection, originPercentage: CGPoint? = nil) -> ActionFactory {
        if let o = originPercentage {
            return ActionFactory { grey_swipeSlowInDirectionWithStartPoint(direction, o.x, o.y) }
        }
        return ActionFactory { grey_swipeSlowInDirection(direction) }
    }

    /// Returns an action that performs a multi-finger slow swipe through the view in the given @c direction from a specified origin.
    static func multiFingerSwipeSlow(direction: GREYDirection, numberOfFingers: UInt, originPercentage: CGPoint? = nil) -> ActionFactory {
        if let o = originPercentage {
            return ActionFactory { grey_multiFingerSwipeSlowInDirectionWithStartPoint(direction, numberOfFingers, o.x, o.y) }
        }
        return ActionFactory { grey_multiFingerSwipeSlowInDirection(direction, numberOfFingers) }
    }

    /// Returns an action that performs a multi-finger fast swipe through the view in the given
    /// @c direction from a specified origin.
    static func multiFingerSwipeFast(direction: GREYDirection, numberOfFingers: UInt, originPercentage: CGPoint? = nil) -> ActionFactory {
        if let o = originPercentage {
            return ActionFactory { grey_multiFingerSwipeFastInDirectionWithStartPoint(direction, numberOfFingers, o.x, o.y) }
        }
        return ActionFactory { grey_multiFingerSwipeFastInDirection(direction, numberOfFingers) }
    }

    /// Returns an action that pinches view quickly in the specified @c direction and @c angle. The angle of the pinch action in radians.
    static func pinchFast(in direction: GREYPinchDirection, angle: Double) -> ActionFactory {
        return ActionFactory { grey_pinchFastInDirectionAndAngle(direction, angle) }
    }

    /// Returns an action that pinches view slowly in the specified @c direction and @c angle. The angle of the pinch action in radians.
    static func pinchSlow(in direction: GREYPinchDirection, angle: Double) -> ActionFactory {
        return ActionFactory { grey_pinchSlowInDirectionAndAngle(direction, angle) }
    }

    // MARK: - Text
    /// Returns an action that uses the iOS keyboard to input a string.
    /// Backspace is supported by using "\u{8}" in Swift strings. Return key is supported with "\n".
    /// For Example: "Helpo\u{8}\u{8}loWorld" will type HelloWorld in Swift.
    /// @return A GREYAction to type a specific text string in a text field.
    static func type(text: String) -> ActionFactory {
        return ActionFactory { grey_typeText(text) }
    }

    /// Returns an action that sets text on a UITextField or webview input directly.
    static func replace(text: String) -> ActionFactory {
        return ActionFactory { grey_replaceText(text) }
    }

    /// A GREYAction that clears a text field by injecting back-spaces.
    static func clearText() -> ActionFactory {
        return ActionFactory { grey_clearText() }
    }

    // MARK: - Other
    /// Returns an action that attempts to move slider to within 1.0e-6f values of @c value.
    static func moveSlider(to value: Float) -> ActionFactory {
        return ActionFactory { grey_moveSliderToValue(value) }
    }

    /// Returns an action that changes the value of UIStepper to @c value by tapping the appropriate button multiple times.
    static func setStepperValue(_ value: Double) -> ActionFactory {
        return ActionFactory { grey_setStepperValue(value) }
    }

    /// Returns an action that toggles a switch control. This action is applicable to all elements that
    /// implement the selector UISwitch::isOn and include UISwitch controls.
    static func setSwitchState(_ state: Bool) -> ActionFactory {
        return ActionFactory { grey_turnSwitchOn(state) }
    }

    /// Returns an action that injects dates/times into UIDatePickers.
    static func set(_ date: Date) -> ActionFactory {
        return ActionFactory { grey_setDate(date) }
    }

    /// Returns an action that selects @c value on the given @c column of a UIPickerView.
    static func set(value: String, to column: Int) -> ActionFactory {
        return ActionFactory { grey_setPickerColumnToValue(column, value) }
    }

    /// Returns an action that executes JavaScript against a UIWebView and sets the return value to @c outResult if provided.
    static func javaScriptExecution(js: String, output: UnsafeMutablePointer<NSString?>?) -> ActionFactory {
        return ActionFactory { grey_javaScriptExecution(js, output) }
    }

    /// Returns an action that takes a snapshot of the selected element.
    static func snapshot(to output: UnsafeMutablePointer<UIImage?>) -> ActionFactory {
        return ActionFactory { grey_snapshot(output) }
    }
}

extension GREYInteraction {
    @discardableResult
    func perform(_ action: ActionFactory, error: UnsafeMutablePointer<NSError?>? = nil) -> Self {
        if let e = error {
            return perform(action.do(), error: e)
        }
        return perform(action.do())
    }
}

extension GREYInteraction {
    @discardableResult
    func using(searchAction: ActionFactory, onElementWithMatcher matcher: Matcher) -> Self {
        return using(searchAction: searchAction.do(), onElementWithMatcher: matcher)
    }
}
