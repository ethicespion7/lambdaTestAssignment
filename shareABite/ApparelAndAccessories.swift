import SwiftUI

struct ApparelAndAccessoriesView: View {
    let apparelAndAccessories = [
        "Clothes",
        "Shoes",
        "Jewelry",
        "Watches",
        "Sunglasses",
        "Bags",
        "Backpacks",
        "Wallets",
        "Belts",
        "Hats",
        "Scarves",
        "Gloves",
        "Umbrellas",
        "Socks",
        "Ties",
        "Cufflinks",
        "Perfume",
        "Makeup",
        "Hair Accessories",
        "Sweaters",
        "Jackets",
        "Coats",
        "Swimwear",
        "Sportswear",
        "Athletic Shoes",
        "Boots",
        "Sandals",
        "Slippers",
        "Briefcases",
        "Tote Bags",
        "Clutches",
        "Luggage Tags",
        "Passport Holders",
        "Gym Bags"
    ]


    @State private var searchText: String = ""
    @State private var selectedItems: [String] = []
    @State private var isShowingCheckout: Bool = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("gradientColor2"), Color("gradientColor1")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    TextField("Search", text: $searchText)
                        .padding(7)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal, 10)
                    
                    Button(action: {
                        searchText = ""
                        hideKeyboard()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
                .padding(.top, 20)
                
                List {
                    ForEach(apparelAndAccessories.filter({ searchText.isEmpty ? true : $0.localizedCaseInsensitiveContains(searchText) }), id: \.self) { item in
                        HStack {
                            Text(item).accessibility(identifier: item)
                            
                            Spacer()
                            
                            if selectedItems.contains(item) {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.green)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if selectedItems.contains(item) {
                                selectedItems.removeAll(where: { $0 == item })
                            } else {
                                selectedItems.append(item)
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .padding(.top, 10)
                .padding(.horizontal, 10)
                
                Spacer()
                
                NavigationLink("", destination:  CheckoutView(selectedItems: selectedItems), isActive: $isShowingCheckout)
                                           .frame(width: 0, height: 0)
                                           .hidden()
                
                Button(action: {
                    isShowingCheckout = true
                }) {
                    Text("Proceed to Checkout (\(selectedItems.count))")
                        .foregroundColor(.white)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background(selectedItems.count > 0 ? Color("buttonColor") : Color.gray)
                        .cornerRadius(10)
                        .disabled(selectedItems.count == 0)
                }
                .accessibility(identifier: "Proceed to Checkout (\(selectedItems.count))")
                .padding(.bottom, 20)
                .padding(.horizontal, 10)
            }
        }

        

    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

