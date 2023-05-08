//
//  HobbiesAndLeisureView.swift
//  shareABite
//
//  Created by chinmay on 06/05/23.
//


import SwiftUI

import SwiftUI

struct HobbiesAndLeisureView: View {
  
    let hobbiesAndLeisure = [
        "Toys",
        "Musical Instruments",
        "Sports Equipment",
        "Art Supplies",
        "Board Games",
        "Camping Gear",
        "Hiking Gear",
        "Sewing Machines",
        "Craft Supplies",
        "Fitness Equipment",
        "Medical Equipment",
        "Wheelchairs",
        "Outdoor Grills",
        "BBQ Accessories",
        "Pool Supplies",
        "Snow Sports Gear",
        "Bikes",
        "Rollerblades",
        "Skateboards",
        "Scooters",
        "Kayaks",
        "Paddleboards",
        "Fishing Gear",
        "Horse Tack",
        "Dog Crates",
        "Cat Trees",
        "Bird Cages",
        "Reptile Tanks",
        "Fish Tanks",
        "Canned Goods",
        "Dry Goods",
        "Baking Supplies",
        "Spices",
        "Tea",
        "Coffee",
        "Energy Drinks",
        "Soda",
        "Juice",
        "Water Bottles",
        "Wine",
        "Beer",
        "Liquor",
        "Champagne",
        "Mixed Drinks",
        "Barware",
        "Bar Stools",
        "Bar Tables",
        "Pool Tables",
        "Dart Boards",
        "Foosball Tables",
        "Ping Pong Tables",
        "Air Hockey Tables"
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
                    ForEach(hobbiesAndLeisure.filter({ searchText.isEmpty ? true : $0.localizedCaseInsensitiveContains(searchText) }), id: \.self) { item in
                        HStack {
                            Text(item)
                            
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
                .padding(.bottom, 20)
                .padding(.horizontal, 10)
            }
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

