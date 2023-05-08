import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoggingIn: Bool = false
    @State private var showingAlert: Bool = false
    @State private var shouldNavigate: Bool = false
    @State private var createNewAccount: Bool = false
    
    @EnvironmentObject var allowedCredentials: AllowedCredentials

    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("gradientColor2"), Color("gradientColor1")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView{
                
                VStack(spacing: 20) {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                    
                    Text("Login to Rent")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color.white)
                    
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5.0)
                        .shadow(radius: 5.0)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .accessibilityIdentifier("loginEmailTextField")
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5.0)
                        .shadow(radius: 5.0)
                        .disableAutocorrection(true)
                        .accessibilityIdentifier("loginPasswordTextField")
                    
                    Button(action: {
                        
                        if email.isEmpty || password.isEmpty {
                            showingAlert = true
                            
                            
                        } else {
                            
                            if email.isEmpty || password.isEmpty {
                                showingAlert = true
                                
                            } else {
                                
                                if let validPassword = allowedCredentials.credentials[email], validPassword == password {
                                    isLoggingIn = true
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                        isLoggingIn = false
                                        
                                        shouldNavigate = true
                                        
                                        UserDefaults.standard.set(true, forKey: "loggedIn")
                                        
                                    }
                                } else {
                                    showingAlert = true
                                }
                                
                            }
                            
                        }
                        
                    }) {
                        Text("Log In")
                            .foregroundColor(Color.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("buttonColor"))
                            .cornerRadius(5.0)
                    }.accessibilityIdentifier("loginButton")
//                        .fullScreenCover(isPresented: $shouldNavigate) {
//                            CategoryView()
//                        }

                    NavigationLink("", destination: CategoryView(), isActive: $shouldNavigate)
                                               .frame(width: 0, height: 0)
                                               .hidden()
                    
                    Button(action: {
                        // Perform forgot password action here
                    }) {
                        Text("Forgot Password?")
                            .foregroundColor(Color.white)
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("Don't have an account?")
                            .foregroundColor(Color.white)
                        
                        NavigationLink(destination: SignUpView(), isActive: $createNewAccount) {
                            Text("Create Account")
                                .foregroundColor(Color.black)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color("button2"))
                                .cornerRadius(5.0)
                        }
                        .isDetailLink(false)
                    }
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Invalid Email or Password"), message: Text("Please enter both email and password"), dismissButton: .default(Text("OK")))
            }
            .padding(.horizontal, 20.0)
            .padding(.vertical, 40.0)
            
            if isLoggingIn {
                ProgressView("Logging In...")
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
