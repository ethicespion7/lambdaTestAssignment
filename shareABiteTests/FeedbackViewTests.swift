import XCTest
@testable import shareABite

class FeedbackViewTests: XCTestCase {

    func testSubmitFeedback() {
        let feedbackView = FeedbackView()

        // Check initial state
        XCTAssertEqual(feedbackView.feedback, "")
        XCTAssertEqual(feedbackView.name, "")
        XCTAssertEqual(feedbackView.email, "")
        XCTAssertEqual(feedbackView.phone, "")
        XCTAssertEqual(feedbackView.isContactAllowed, false)

        // Set some state
        feedbackView.feedback = "Great app!"
        feedbackView.name = "Test User"
        feedbackView.email = "test@user.com"
        feedbackView.phone = "1234567890"
        feedbackView.isContactAllowed = true

        // Call submitFeedback function
        feedbackView.submitFeedback()

        // Check that state is reset after submitting feedback
        XCTAssertEqual(feedbackView.feedback, "")
        XCTAssertEqual(feedbackView.name, "")
        XCTAssertEqual(feedbackView.email, "")
        XCTAssertEqual(feedbackView.phone, "")
        XCTAssertEqual(feedbackView.isContactAllowed, false)
    }
}
