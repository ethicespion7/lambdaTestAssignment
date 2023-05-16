import SwiftUI

struct ContentView: View {
    
   
    @State private var isLoggedIn: Bool = false
    //UserDefaults.standard.bool(forKey: "loggedIn")

    var body: some View {
        NavigationView {
            if isLoggedIn {
               CategoryView()
            } else {
                SignUpView()
             
            }
        }.environmentObject(AllowedCredentials())
    }
}

