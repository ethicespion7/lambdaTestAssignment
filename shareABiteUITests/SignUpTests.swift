import XCTest
import AVFoundation


class SignUpTests: XCTestCase {
    var app: XCUIApplication!
    var generatedEmail: String!
    var generatedPassword: String!
    let synthesizer = AVSpeechSynthesizer()


    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()

        generatedEmail = "chintu@gmail.com"
        generatedPassword = "chintu1234"
    }


    func testSignUp() {
        
        
        
        let emailTextField = app.textFields["emailTextField"]
        emailTextField.tap()
        speak("Email text field")
        
        emailTextField.typeText(generatedEmail)
        
        
       

        let passwordTextField = app.secureTextFields["passwordTextField"]
        passwordTextField.tap()
        speak("Password text field")
        
        passwordTextField.typeText(generatedPassword)
        
       

        let confirmPasswordTextField = app.secureTextFields["confirmPasswordTextField"]
        confirmPasswordTextField.tap()
        speak("Confirm Password text field")
        
        confirmPasswordTextField.typeText(generatedPassword)
       
       

        let signUpButton = app.buttons["signUpButton"]
        signUpButton.tap()
        speak("Sign Up button")
        
    }
    
    func testSignUpAndLogin() {
        // Enter email and password in SignUpView
        
       
        let directLogin = app.buttons["directLogin"]
        
        directLogin.tap()
        speak("Sign Up Button")
        

       
        let loginEmailTextField = app.textFields["loginEmailTextField"]
        // Enter the same email and password in LoginView
        loginEmailTextField.tap()
        speak("Email Text Field")
        
        loginEmailTextField.typeText(generatedEmail)


        let loginPasswordTextField = app.secureTextFields["loginPasswordTextField"]
       
        loginPasswordTextField.tap()
        speak("Password Text Field")
        
        loginPasswordTextField.typeText(generatedPassword)
        sleep(5)

        let loginButton = app.buttons["loginButton"]
        loginButton.tap()
        speak("Login Button")
        

    }
    
    
    func testPlaceAnOrder() {
        let directLogin = app.buttons["directLogin"]

        directLogin.tap()
        speak("Already Exist an account")

        let loginEmailTextField = app.textFields["loginEmailTextField"]
        loginEmailTextField.tap()
        speak("Email Text Field")

        loginEmailTextField.typeText(generatedEmail)

        let loginPasswordTextField = app.secureTextFields["loginPasswordTextField"]

        loginPasswordTextField.tap()
        speak("Password Text Field")

        loginPasswordTextField.typeText(generatedPassword)
        sleep(5)

        let loginButton = app.buttons["loginButton"]
        loginButton.tap()
        speak("Login Button")

        // Choose a category from the CategoryView
        let categoryButton = app.buttons["Apparel and Accessories"] // Replace "Apparel and Accessories" with the desired category name
        categoryButton.tap()
        speak("Category Button")
        
        
    }


    
    func speak(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        synthesizer.speak(utterance)

        // Wait for the speech to complete
        while synthesizer.isSpeaking {
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))
        }
    }

}
