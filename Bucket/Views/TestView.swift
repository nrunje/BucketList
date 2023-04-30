import SwiftUI

struct BucketlistView: View {
    // A sample array of bucketlist items
    let items = [
        BucketlistItem(image: "mountain", title: "Climb Mount Everest", location: "Nepal", date: "2023-04-01"),
        BucketlistItem(image: "airplane", title: "Fly around the world", location: "Various", date: "2024-01-01"),
        BucketlistItem(image: "book", title: "Write a novel", location: "Home", date: "2025-06-01")
    ]
    
    var body: some View {
        // A list view that iterates over the items array
        List(items) { item in
            // A custom card view for each item
            CardView(item: item)
                // Apply a neumorphic style to the card view
                .modifier(NeumorphicStyle())
        }
        // Set the list style to inset group
        .listStyle(.insetGrouped)
    }
}

// A struct that represents a bucketlist item
struct BucketlistItem: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let location: String
    let date: String
}

// A custom view that displays a bucketlist item as a card
struct CardView: View {
    let item: BucketlistItem
    
    var body: some View {
        HStack {
            // An image view with a circular shape and a shadow
            Image(systemName: item.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .padding()
                .foregroundColor(.blue)
                .shadow(color: .gray, radius: 2, x: 1, y: 1)
            
            // A vertical stack of text views for the title, location and date
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(item.location)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(item.date)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
    }
}

// A custom modifier that applies a neumorphic style to a view
struct NeumorphicStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            // Add a background color with some padding and corner radius
            .background(Color(.systemGray6))
            .padding()
            .cornerRadius(10)
            // Add two shadows, one dark and one light, to create a 3D effect
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: -5, y: -5)
            .shadow(color: Color.white.opacity(0.7), radius: 10, x: 10, y: 10)
    }
}


struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        BucketlistView()
    }
}
