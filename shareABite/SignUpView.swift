import SwiftUI

import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var proceed: Bool = false
    @State private var showingAlert: Bool = false
    @EnvironmentObject var allowedCredentials: AllowedCredentials

    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("g4"), Color("g3")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                
                Text("Create Your Account")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Email Address")
                        .font(.subheadline)
                        .foregroundColor(.white)
                    
                    TextField("", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .background(Color.white.opacity(0.3))
                        .cornerRadius(10)
                        .accessibilityIdentifier("emailTextField")
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Invalid Email Address"), message: Text("Please enter a valid email address"), dismissButton: .default(Text("OK")))
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Password")
                        .font(.subheadline)
                        .foregroundColor(.white)
                    
                    SecureField("", text: $password)
                        .padding()
                        .background(Color.white.opacity(0.3))
                        .cornerRadius(10)
                        .accessibilityIdentifier("passwordTextField")
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Confirm Password")
                        .font(.subheadline)
                        .foregroundColor(.white)
                    
                    SecureField("", text: $confirmPassword)
                        .padding()
                        .background(Color.white.opacity(0.3))
                        .cornerRadius(10)
                        .accessibilityIdentifier("confirmPasswordTextField")

                }
                
                Button(action: {
                    if !isValidEmail(email) {
                          showingAlert = true
                      } else if password != confirmPassword {
                          showingAlert = true
                      } else {
                          allowedCredentials.credentials[email] = password
                          proceed = true
                          UserDefaults.standard.set(true, forKey: "loggedIn")
                      }
                }) {
                    Text("Sign Up")
                        .foregroundColor(Color("buttonText"))
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color("button2"))
                        .cornerRadius(10)
                        .padding(.top, 20)
                }
                .accessibilityIdentifier("signUpButton")
                .fullScreenCover(isPresented: $proceed) {
                    LoginView()
                }
                
                Spacer()
                
                HStack {
                    Text("Already have an account?")
                        .foregroundColor(.white)
                    
                    NavigationLink(destination: LoginView()) {
                        Text("Log In")
                            .foregroundColor(Color("button2"))
                            .bold()
                            .accessibilityIdentifier("directLogin")
                    }
                }
                
                HStack {
                    Spacer()
                    
                    NavigationLink(destination:FeedbackView()){
                        Text("Write A Feedback")
                            .foregroundColor(.white)
                        
                        Image(systemName: "square.and.pencil")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.black)
                            .clipShape(Circle())
                            .accessibilityIdentifier("feedbackButton")
                        
                        
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 30)

        }
        
        

    
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
