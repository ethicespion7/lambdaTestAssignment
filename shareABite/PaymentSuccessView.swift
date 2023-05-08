import SwiftUI

struct PaymentSuccessView: View {
    
    @State private var proceed: Bool = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("gradientColor2"), Color("gradientColor1")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .foregroundColor(Color.green)
                    .frame(width: 80.0, height: 80.0)
                
                Text("Payment Successful")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .padding(.top, 20.0)
                
                Text("Your payment has been successfully processed.")
                    .font(.headline)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20.0)
                
                Spacer()
                
                
                NavigationLink("", destination:ContentView() , isActive: $proceed)
                                           .frame(width: 0, height: 0)
                                           .hidden()
                
                
                Button(action: {
                    // Handle button action
                    proceed = true
                }) {
                    Text("Done")
                        .foregroundColor(Color.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("button2"))
                        .cornerRadius(5.0)
                }
                .padding(.horizontal, 20.0)
                .padding(.bottom, 20.0)
            }
        }
    }
}
