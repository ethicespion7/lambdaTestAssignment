import XCTest
import AVFoundation

class FeedbackViewTests: XCTestCase {
    var app: XCUIApplication!
    let synthesizer = AVSpeechSynthesizer()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testFeedbackFlow() throws {
        app.buttons["feedbackButton"].tap()

        // Fetch all buttons with an accessibility identifier
        let buttons = app.buttons.allElementsBoundByAccessibilityElement.filter { !$0.identifier.isEmpty }
        // Fetch all text fields with an accessibility identifier
        let textFields = app.textFields.allElementsBoundByAccessibilityElement.filter { !$0.identifier.isEmpty }
        // Fetch all text views with an accessibility identifier
        let textViews = app.textViews.allElementsBoundByAccessibilityElement.filter { !$0.identifier.isEmpty }
        
        // Combine all elements into one list
        let allElements: [XCUIElement] = buttons + textFields + textViews
        
        // Perform operations on elements
        for (index, element) in allElements.enumerated() {
            if element.elementType == .textField || element.elementType == .textView {
                element.tap()
                speakAccessibilityLabel(element)
                
                // Enter appropriate text based on the label of the field
                if element.label.lowercased().contains("phone") {
                    let randomNumber = Int.random(in: 1000000000..<10000000000)
                    element.typeText("\(randomNumber)")
                } else if element.label.lowercased().contains("email") {
                    element.typeText("john.doe@gmail.com")
                } else if element.label.lowercased().contains("name") {
                    element.typeText("John Doe")
                } else if element.label.lowercased().contains("suggestion") || element.label.lowercased().contains("feedback") {
                    element.typeText("This is a random text for the feedback and suggestion.")
                } else {
                    element.typeText("This is a random text for input")
                }

                // Move focus to the next element if it exists
                if index < allElements.count - 1 {
                    allElements[index + 1].tap()
                }
            }
        }
        
        // Submit feedback
        let submitButton = app.buttons["feedbackButton"]
        if !submitButton.isEnabled { return }
        submitButton.tap()
        
        // Wait for alert and dismiss
        XCTAssertTrue(app.alerts["Feedback Submitted"].waitForExistence(timeout: 5))
        app.alerts["Feedback Submitted"].buttons["OK"].tap()
    }

    private func speakAccessibilityLabel(_ element: XCUIElement) {
        if !element.label.isEmpty {
            speak(element.label)
        } else {
            speak("Not accessibility element")
        }
    }

    func speak(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        synthesizer.speak(utterance)

        // Wait for the speech to complete
        while synthesizer.isSpeaking {
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 2))
        }
    }
}
