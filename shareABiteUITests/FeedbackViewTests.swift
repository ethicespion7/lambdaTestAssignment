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
        // Navigate to FeedbackView
        app.buttons["feedbackButton"].tap()

        // Enter feedback details
        let feedbackField = app.textViews["Feedback"]
        feedbackField.tap()
        speakAccessibilityLabel(feedbackField)
        feedbackField.typeText("Since I've been using this app for a few days, I've been blown away by how simple it is to navigate and find what I'm looking for. The layout is neat and contemporary, and the color scheme is quite aesthetically pleasant.")
        

        let nameField = app.textFields["nameTextField"]
        nameField.tap()
        speakAccessibilityLabel(nameField)
            nameField.typeText("Chinmay")
        
        
        

        let phoneField = app.textFields["phoneTextField"]
        phoneField.tap()
        speakAccessibilityLabel(phoneField)
        sleep(2)
        phoneField.typeText("8180011428")
      

        let emailField = app.textFields["emailTextField"]
        emailField.tap()
        speakAccessibilityLabel(emailField)
        sleep(2)
        emailField.typeText("chinmaytayade@lambdatest.com")


        let contactToggle = app.switches["contactToggle"]
        contactToggle.tap()
        speakAccessibilityLabel(contactToggle)

        let improvementField = app.textViews["Suggestion"]
        improvementField.tap()
        speakAccessibilityLabel(improvementField)
        improvementField.typeText("I think there are a few areas that may be addressed to improve the user experience based on my experience using your app. First, the software could utilise more user-friendly and straightforward navigation")
       

        // Submit feedback
        app.buttons["feedbackButton"].tap()

        // Wait for alert and dismiss
        XCTAssertTrue(app.alerts["Feedback Submitted"].waitForExistence(timeout: 5))
        app.alerts["Feedback Submitted"].buttons["OK"].tap()
    }

    private func speakAccessibilityLabel(_ element: XCUIElement) {
        if let label: String? = element.label {
            speak(label ?? "No accessibility label found")
        } else {
            print("No accessibility label found")
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

