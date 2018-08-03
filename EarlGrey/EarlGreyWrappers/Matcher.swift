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

indirect enum Matcher {
    // MARK: - Accessibility
    /// Matcher to check if a UI element is accessible.
    case accessibilityElement
    /// Matcher for UI element with the provided accessiblity @c hint.
    case accessibilityFocused
    /// Matcher for UI element with the provided accessibility @c label.
    case accessibilityLabel(String)
    /// Matcher for UI element with the provided accessibility ID @c accessibilityID.
    case accessibilityID(String)
    /// Matcher for UI element with the provided accessibility @c value.
    case accessibilityValue(String)
    /// Matcher for UI element with the provided accessibility @c traits.
    case accessibilityTrait(UIAccessibilityTraits)
    /// Matcher for UI element with accessiblity focus.
    case accessibilityHint(String)

    // MARK: - Hierarchy
    /// Matcher that matches UI element based on the presence of an ancestor in its hierarchy. The given matcher is used to match decendants.
    case ancestor(Matcher)
    /// Matcher that matches any UI element with a descendant matching the given matcher.
    case descendant(Matcher)

    // MARK: - Comparison
    /// A Matcher for NSNumbers that matches when the examined number is within a specified @c delta from the specified value.
    case closeTo(value: Double, delta: Double)
    /// A Matcher that checks if a provided object is equal to the specified @c value. The equality is
    /// determined by calling the @c isEqual: method of the object being examined. In case the @c
    /// value is @c nil, then the object itself is checked to be @c nil.
    case equalTo(Any)
    /// A Matcher that checks if a provided object is less than a specified @c value. The comparison
    /// is made by calling the @c compare: method of the object being examined.
    case lessThan(Any)
    /// A Matcher that checks if a provided object is greater than a specified @c value. The comparison
    /// is made by calling the @c compare: method of the object being examined.
    case greaterThan(Any)

    // MARK: - Grouping
    /// A shorthand matcher that is a logical AND of all the matchers passed in within an array.
    case all([Matcher])
    /// A shorthand matcher that is a logical OR of all the matchers passed in within an array.
    case any([Matcher])
    /// A matcher to negate the result of another matcher.
    case not(Matcher)

    // MARK: - Class
    /// Matcher for elements that are instances of the provided @c klass or any class that inherits from it.
    case kindOfClass(AnyClass)
    /// Matcher for UI element that respond to the provided @c sel.
    case respondsToSelector(Selector)
    /// Matcher for UI element that conform to the provided @c protocol.
    case conformsToProtocol(Protocol)

    // MARK: - Other
    /// Matcher for application's key window.
    case keyWindow
    /// Matcher to check if system alert view is shown.
    case systemAlertViewShown
    /// Matcher primarily for asserting that the element is @c nil or not found.
    case `nil`
    /// Matcher for asserting that the element exists in the UI hierarchy (i.e. not @c nil).
    case notNil
    /// A Matcher that matches against any object, including @c nils.
    case anything

    // MARK: - UIProperties
    /// Matcher for UI elements of type UIButton, UILabel, UITextField or UITextView displaying the provided @c inputText.
    case text(String)
    /// Matcher for element that is the first responder.
    case firstResponder
    /// Matcher for UI element whose percent visible area (of its accessibility frame) exceeds the given @c percent.
    case minimumVisiblePercent(CGFloat)
    /// Matcher for UI element that is sufficiently visible to the user. EarlGrey considers elements that are more
    /// than @c kElementSufficientlyVisiblePercentage (75 %) visible areawise to be sufficiently visible.
    case sufficientlyVisible
    /// Matcher for UI element that matches EarlGrey's criteria for user interaction. Currently it must satisfy at least the following criteria:
    /// 1) At least a few pixels of the element are visible to the user.
    /// 2) The element's accessibility activation point OR the center of the element's visible area is completely visible.
    case interactable
    /// Matcher for UI element that is not visible to the user at all i.e. it has a zero visible area.
    case notVisible
    /// Matcher for matching UIProgressView's values. Use greaterThan, greaterThanOrEqualTo, lessThan etc to create @c comparisonMatcher.
    /// For example, to match the UIProgressView elements that have progress value greater than 50.2, use
    /// @code .progress(.greaterThan(50.2)) @endcode.
    case progress(Matcher)
    /// Matcher that matches UIButton that has title label as @c text.
    case buttonTitle(String)
    /// Matcher that matches UIScrollView that has contentOffset as @c offset.
    case scrollViewContentOffset(CGPoint)
    /// Matcher that matches UIStepper with value as @c value.
    case stepperValue(Double)
    /// Matcher that matches a UISlider's value. You must provide a valid @c valueMatcher for the floating point value comparison.
    /// The @c valueMatcher should be of the type @c closeTo, @c greaterThan, @c lessThan, @c lessThanOrEqualTo, @c greaterThanOrEqualTo.
    case sliderValueMatcher(Matcher)
    /// Matcher that matches UIPickerView that has a column set to @c value.
    case pickerColumnSetToValue(column: Int, value: String)
    /// Matcher that matches UIDatePicker that is set to @c value.
    case datePickerValue(Date)
    /// Matcher that verifies whether an element, that is a UIControl, is enabled.
    case enabled
    /// Matcher that verifies whether an element, that is a UIControl, is selected.
    case selected
    /// Matcher that verifies whether a view has its userInteractionEnabled property set to @c YES.
    case userInteractionEnabled
    /// Matcher that verifies that the selected element satisfies the given constraints to the reference element.
    case layout([GREYLayoutConstraint], to: Matcher)
    /// Matcher for toggling the switch control.
    case switchWithOnState(Bool)
    /// Matcher that matches a UIScrollView scrolled to content @c edge.
    case scrolledToContentEdge(GREYContentEdge)
    /// Matcher that matches a UITextField's content.
    case textFieldValue(String)

    fileprivate func toGrey() -> GREYMatcher {
        switch self {
        case .accessibilityElement:
            return grey_accessibilityElement()

        case .accessibilityFocused:
            return grey_accessibilityFocused()

        case .accessibilityLabel(let s):
            return grey_accessibilityLabel(s)

        case .accessibilityID(let s):
            return grey_accessibilityID(s)

        case .accessibilityValue(let s):
            return grey_accessibilityValue(s)

        case .accessibilityTrait(let t):
            return grey_accessibilityTrait(t)

        case .accessibilityHint(let s):
            return grey_accessibilityHint(s)

        case .ancestor(let m):
            return grey_ancestor(m.toGrey())

        case .descendant(let m):
            return grey_descendant(m.toGrey())

        case .closeTo(let v, let d):
            return grey_closeTo(v, d)

        case .equalTo(let a):
            return grey_equalTo(a)

        case .lessThan(let a):
            return grey_lessThan(a)

        case .greaterThan(let a):
            return grey_greaterThan(a)

        case .all(let matchers):
            return grey_allOf(matchers.map({ $0.toGrey() }))

        case .any(let matchers):
            return grey_anyOf(matchers.map({ $0.toGrey() }))

        case .not(let m):
            return grey_not(m.toGrey())

        case .kindOfClass(let c):
            return grey_kindOfClass(c)

        case .respondsToSelector(let s):
            return grey_respondsToSelector(s)

        case .conformsToProtocol(let p):
            return grey_conformsToProtocol(p)

        case .keyWindow:
            return grey_keyWindow()

        case .systemAlertViewShown:
            return grey_systemAlertViewShown()

        case .`nil`:
            return grey_nil()

        case .notNil:
            return grey_notNil()

        case .anything:
            return grey_anything()

        case .text(let s):
            return grey_text(s)

        case .firstResponder:
            return grey_firstResponder()

        case .minimumVisiblePercent(let p):
            return grey_minimumVisiblePercent(p)

        case .sufficientlyVisible:
            return grey_sufficientlyVisible()

        case .interactable:
            return grey_interactable()

        case .progress(let m):
            return grey_progress(m.toGrey())

        case .buttonTitle(let s):
            return grey_buttonTitle(s)

        case .scrollViewContentOffset(let p):
            return grey_scrollViewContentOffset(p)

        case .stepperValue(let d):
            return grey_stepperValue(d)

        case .sliderValueMatcher(let m):
            return grey_sliderValueMatcher(m.toGrey())

        case .pickerColumnSetToValue(let column, let value):
            return grey_pickerColumnSetToValue(column, value)

        case .datePickerValue(let d):
            return grey_datePickerValue(d)

        case .enabled:
            return grey_enabled()

        case .selected:
            return grey_selected()

        case .userInteractionEnabled:
            return grey_userInteractionEnabled()

        case .layout(let c, let m):
            return grey_layout(c, m.toGrey())

        case .switchWithOnState(let s):
            return grey_switchWithOnState(s)

        case .scrolledToContentEdge(let e):
            return grey_scrolledToContentEdge(e)

        case .textFieldValue(let s):
            return grey_textFieldValue(s)

        case .notVisible:
            return grey_notVisible()
        }
    }
}

extension EarlGrey {
    class func selectElement(with matcher: Matcher, file: StaticString = #file, line: UInt = #line) -> GREYInteraction {
        return selectElement(with: matcher.toGrey(), file: file, line: line)
    }
}

extension GREYInteraction {
    @discardableResult func assert(_ matcher: @autoclosure () -> Matcher, error: UnsafeMutablePointer<NSError?>? = nil) -> Self {
        if let e = error {
            return assert(matcher().toGrey(), error: e)
        }
        return assert(matcher().toGrey())
    }

    @discardableResult func using(searchAction: GREYAction, onElementWithMatcher matcher: Matcher) -> Self {
        return usingSearch(searchAction, onElementWith: matcher.toGrey())
    }
}
