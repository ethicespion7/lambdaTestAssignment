import SwiftUI

struct CategoryView: View {
    struct Category: Identifiable {
        var id: String
        var name: String
    }

    var categories = [
        Category(id: "apparel", name: "Apparel and Accessories"),
        Category(id: "home", name: "Home and Garden"),
        Category(id: "electronics", name: "Electronics"),
        Category(id: "hobbies", name: "Hobbies and Leisure")
    ]

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("gradientColor2"), Color("gradientColor1")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack(spacing: 20) {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)

                    Text("Choose a Category")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color.white)

                    ForEach(categories) { category in
                        NavigationLink(destination: Group {
                            switch category.id {
                            case "apparel":
                                ApparelAndAccessoriesView()
                            case "home":
                                HomeAndGardenView()
                            case "electronics":
                                ElectronicsView()
                            case "hobbies":
                                HobbiesAndLeisureView()
                            default:
                                EmptyView()
                            }
                        }) {
                            Text(category.name)
                                .foregroundColor(Color.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color("ColorNew"))
                                .cornerRadius(5.0)
                        }
                        .accessibility(identifier: category.name) // Add this line
                    }

                    Spacer()

                    VStack {
                        Text("Don't see what you're looking for?")
                            .foregroundColor(Color.white)

                        NavigationLink(destination: EmptyView()) {
                            Text("Other")
                                .foregroundColor(Color.black)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color("button2"))
                                .cornerRadius(5.0)
                        }
                    }
                }
                .padding(.horizontal, 20.0)
                .padding(.vertical, 40.0)
            }
        }
    }
}
