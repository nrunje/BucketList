//
//  HomeView.swift
//  Bucket
//
//  Created by Nicholas Runje on 4/28/23.
//

import SwiftUI

struct HomeView: View {
    @State private var userBucketItems = [BucketItem]()
    @State private var isLoading = true
    @State private var selectedItem: BucketItem? = nil
    
    var body: some View {
        ScrollView {
            Rectangle()
                .fill(Color.blue.opacity(0.6))
                .frame(width: UIScreen.main.bounds.width, height: 150)
                .cornerRadius(10)
                .edgesIgnoringSafeArea(.top)
            
            Text("My BucketList")
                .font(.system(size: 36))
                .fontWeight(.bold)
                .padding(.top, -70)
            
            if isLoading {
                ProgressView()
                    .scaleEffect(2)
                    .padding(.top, 50)
            } else {
                ForEach(userBucketItems) { item in
                    ItemCard(item: item)
                        .onTapGesture {
                            selectedItem = item
                        }
                        
                    ThreeDotsView()
                    
                }
            }
            
        }
        .sheet(item: $selectedItem) { item in
            BucketHomeView(item: item)
        }
        .padding(.zero) // set padding to zero to remove any spacing around the ScrollView
        .edgesIgnoringSafeArea(.top) // ignore top safe area
        .onAppear {
            let currToken = NetworkManager.session_token
            
            NetworkManager.shared.getUserItems(session_token: currToken) { result in
                DispatchQueue.main.async {
                    userBucketItems = result.items
                    print("Loaded the user's individual buckets correctly")
                    isLoading = false
                }
            }
        }
    }
    
}

struct ItemCard: View {
    
    // Variables
    let item: BucketItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            RemoteImage(urlString: item.photo.base_url) // replace placeholder image with RemoteImage
//                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width * 0.9, height: 200)
                .clipped()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(item.name)
                    .font(.title2)
                    .fontWeight(.bold)
                
                HStack {
                    Text(item.location)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text(item.date)
                        .foregroundColor(.secondary)
                }
                
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct RemoteImage: View {
    let urlString: String
    
    var body: some View {
        Group {
            if let url = URL(string: urlString), let imageData = try? Data(contentsOf: url), let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
            } else {
                Image(systemName: "photo") // fallback image
                    .resizable()
            }
        }
    }
}

struct ThreeDotsView: View {
    var body: some View {
        VStack(spacing: 8) {
            Circle()
                .fill(Color.gray)
                .frame(width: 8, height: 8)
            
            Circle()
                .fill(Color.gray)
                .frame(width: 8, height: 8)
            
            Circle()
                .fill(Color.gray)
                .frame(width: 8, height: 8)
        }
        .padding([.top, .bottom], 10)
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
