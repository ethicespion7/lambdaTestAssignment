import SwiftUI

struct CheckoutView: View {
    
    @State private var proceed: Bool = false
    let selectedItems: [String]
    let deliveryCost: Double = 5.0
    let gstRate: Double = 0.18
    let serviceCharge: Double = 2.0
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var totalAmount: Double {
        let itemCost = Double(selectedItems.count) * 10.0 // assuming each item costs ₹10
        let gstAmount = itemCost * gstRate
        let totalCost = itemCost + deliveryCost + gstAmount + serviceCharge
        return totalCost.rounded(toPlaces: 2)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("gradientColor2"), Color("gradientColor1")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ScrollView {
                    VStack(spacing: 20) {
                        
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                        
                        
                        ForEach(selectedItems, id: \.self) { item in
                            HStack {
                                Text(item)
                                    .foregroundColor(Color.black)
                                Spacer()
                                Text("₹10.0")
                                    .foregroundColor(Color.black)
                            }
                        }
                    }
                    .padding()
                }
                
                VStack(spacing: 20) {
                    HStack {
                        Text("Delivery Cost")
                            .foregroundColor(Color.black)
                        Spacer()
                        Text("₹\(deliveryCost, specifier: "%.2f")")
                            .foregroundColor(Color.black)
                    }
                    
                    HStack {
                        Text("GST (\(gstRate * 100)%)")
                            .foregroundColor(Color.black)
                        Spacer()
                        Text("₹\(totalAmount - deliveryCost - serviceCharge, specifier: "%.2f")")
                            .foregroundColor(Color.black)
                    }
                    
                    HStack {
                        Text("Service Charge")
                            .foregroundColor(Color.black)
                        Spacer()
                        Text("₹\(serviceCharge, specifier: "%.2f")")
                            .foregroundColor(Color.black)
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("Total")
                            .foregroundColor(Color.black)
                            .font(.headline)
                        Spacer()
                        Text("₹\(totalAmount, specifier: "%.2f")")
                            .foregroundColor(Color.black)
                            .font(.headline)
                    }
                }
                .padding()
                
                Spacer()
                
                NavigationLink("", destination:PaymentSuccessView() , isActive: $proceed)
                                           .frame(width: 0, height: 0)
                                           .hidden()
                
                Button(action: {
                    // Perform payment action here
                    proceed  = true
                    
                }) {
                    Text("Pay ₹\(totalAmount, specifier: "%.2f")")
                        .foregroundColor(Color.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("button2"))
                        .cornerRadius(5.0)
                }
                .padding(.horizontal, 20.0)
                .padding(.vertical, 10.0)
            }

            .navigationBarTitle("Checkout", displayMode: .inline)
            .navigationBarBackButtonHidden(false)
                        .navigationBarItems(leading:
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(systemName: "logo")
                                    .foregroundColor(.black)
                            }
                        )
        }
    }
    
}

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
