import SwiftUI

struct Category: Identifiable {
    let id = UUID()
    let name: String
    let items: [String]
}

struct ProductView: View {
    
    let categories = [
        Category(name: "Apparel and Accessories", items: [
            "Clothes",
            "Shoes",
            "Accessories"
        ]),
        Category(name: "Home and Garden", items: [
            "Furniture",
            "Kitchen Appliances",
            "Bedding",
            "Home Decor",
            "Cleaning Supplies",
            "Gardening Tools"
        ]),
        Category(name: "Electronics", items: [
            "Computers",
            "Tablets",
            "Cell Phones",
            "Cameras",
            "Video Games",
            "TVs"
        ]),
        Category(name: "Hobbies and Leisure", items: [
            "Books",
            "Toys",
            "Musical Instruments",
            "Sports Equipment",
            "Board Games",
            "Outdoor Gear"
        ])
    ]
    
    @State private var searchText: String = ""
    
    @State private var selectedCategoryIndex = 0
    
    @State private var isSidebarCollapsed = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Button(action: {
                    isSidebarCollapsed.toggle()
                }) {
                    
                    
                    
                    Image(systemName: isSidebarCollapsed ? "chevron.right.circle.fill" : "chevron.left.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .foregroundColor(.blue)
                        .padding(.top, 30)
                        .padding(.leading, 20)
                }
                
                if !isSidebarCollapsed {
                    Text("Categories")
                        .font(.title)
                        .bold()
                        .padding(.leading, 20)
                        .padding(.top, 30)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 10) {
                            ForEach(categories) { category in
                                Button(action: {
                                    selectedCategoryIndex = categories.firstIndex(where: { $0.id == category.id }) ?? 0
                                    isSidebarCollapsed.toggle()
                                }) {
                                    Text(category.name)
                                        .foregroundColor(selectedCategoryIndex == categories.firstIndex(where: { $0.id == category.id }) ?? 0 ? Color.white : Color.black)
                                }
                                .frame(width: 150, height: 50)
                                .background(selectedCategoryIndex == categories.firstIndex(where: { $0.id == category.id }) ?? 0 ? Color.blue : Color.white)
                                .cornerRadius(10)
                                .padding(.leading, 20)
                            }
                        }
                        .padding(.bottom, 20)
                    }
                }
            }
            .frame(width: isSidebarCollapsed ? 50 : 200)
            .background(Color.gray.opacity(0.1))
            
            VStack {
                HStack {
                    TextField("Search", text: $searchText)
                        .padding(.leading, 20)
                        .padding(.trailing, 10)
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding(.trailing, 20)
                }
                .background(Color.white)
                .cornerRadius(20)
                .padding(.horizontal, 20)
                .padding(.top, 30)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 10) {
                        ForEach(categories[selectedCategoryIndex].items.filter { searchText.isEmpty ? true : $0.localizedCaseInsensitiveContains(searchText) }, id: \.self) { item in
                            Text(item)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                                .padding(.horizontal, 20)
                        }
                    }
                    .padding(.bottom, 20)
                }
            }
            .background(Color.white)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView()
    }
}
