import Foundation
import SwiftUI

struct FeedbackView: View {
    @State private var rating: Int = 0
    @State private var feedback: String = ""
    @State private var suggestion: String = ""
    @State private var isSubmitting: Bool = false
    @State private var showingAlert: Bool = false
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var isContactAllowed: Bool = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("gradientColor2"), Color("gradientColor1")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                    
                    Text("We'd Love Your Feedback!")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color.white)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("What Do You Like About Us?")
                            .font(.subheadline)
                            .foregroundColor(.white)
                        
                        TextEditor(text: $feedback)
                            .foregroundColor(Color.black)
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(10)
                            .frame(height: 100)
                            .accessibility(identifier:"Feedback")
                            .accessibility(label:Text("Click on the Field to write About Us"))
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Name")
                            .font(.subheadline)
                            .foregroundColor(.white)
                        
                        TextField("", text: $name)
                            .padding()
                            .foregroundColor(Color.white)
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(10)
                            .accessibility(identifier:"nameTextField")
                            .accessibility(label: Text("Click on the Field to provide Name"))

                    }
                    

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Phone")
                            .font(.subheadline)
                            .foregroundColor(.white)
                        
                        TextField("", text: $phone)
                            .padding()
                            .foregroundColor(Color.white)
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(10)
                            .keyboardType(.phonePad)
                            .accessibility(identifier:"phoneTextField")
                            .accessibility(label: Text("Click on the Field to enter your phone number"))
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Email Address")
                            .font(.subheadline)
                            .foregroundColor(.white)
                        
                        TextField("", text: $email)
                            .foregroundColor(Color.white)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .padding()
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(10)
                            .accessibility(identifier: "emailTextField")
                            .accessibility(label: Text("Click on the Field to enter your email address"))
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Toggle(isOn: $isContactAllowed) {
                            Text("Allow us to contact you?")
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                        .toggleStyle(SwitchToggleStyle(tint: Color("buttonColor")))
                        .accessibility(identifier: "contactToggle")
                        .accessibility(label: Text("Toggle the switch to Allow"))
                        
                    }
                    
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Tell Us Where To Improve")
                            .font(.subheadline)
                            .foregroundColor(.white)
                        
                        TextEditor(text: $suggestion)
                            .foregroundColor(Color.black)
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(10)
                            .frame(height: 100)
                            .accessibility(identifier: "Suggestion")
                            .accessibility(label: Text("Click on the Field to provide Suggestion"))
                        
                        Spacer()
                        
                        
                        Button(action: {
                                submitFeedback()
                        }) {
                            Text("Submit Feedback")
                                .foregroundColor(Color.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color("buttonColor"))
                                .cornerRadius(5.0)
                        }
                        .accessibility(identifier: "feedbackButton")
                        .accessibility(label: Text("click on the button to Submit your suggestion"))

                    }
                
                        
                       
                        
                        //                    Spacer()
                        

                }
                .padding(.horizontal, 20.0)
                .padding(.vertical, 40.0)
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Feedback Submitted"), message: Text("Thank you for your feedback!"), dismissButton: .default(Text("OK")))
            }
            .disabled(isSubmitting)
            .blur(radius: isSubmitting ? 5 : 0)
            .overlay(
                isSubmitting ? ProgressView("Submitting Feedback...") : nil
            )
        }
    }
    
    private func submitFeedback() {
        isSubmitting = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            isSubmitting = false
            showingAlert = true
            suggestion = ""
            rating = 0
            feedback = ""
            name = ""
            email = ""
            phone = ""
            isContactAllowed = false
        }
    }
}


