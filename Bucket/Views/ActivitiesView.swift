//
//  ActivitiesView.swift
//  Bucket
//
//  Created by Nicholas Runje on 4/25/23.
//

import SwiftUI

struct ActivitiesView: View {
    @State private var selectedItem: BucketItem? = nil
//    @State private var bucketItems = [BucketItem]()
    
    var body: some View {
        ScrollView {
            Rectangle()
                .fill(Color.blue.opacity(0.6))
                .frame(width: UIScreen.main.bounds.width, height: 150)
                .cornerRadius(10)
                .edgesIgnoringSafeArea(.top)
            
            Text("Discover")
                .font(.system(size: 36))
                .fontWeight(.bold)
                .padding(.top, -70)
            
            Text("Below are popular bucket list items. Click one to learn more. Or create your own!")
                .italic()
                .opacity(0.6)
                .multilineTextAlignment(.center)
                .padding([.trailing, .leading], 20)
                .padding(.bottom, 10)
            
            // Popular places
            VStack(alignment: .leading) {
                Text("Popular Destinations:")
                    .font(.headline)
                    .padding([.leading])
                    .padding(.top, 5)
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(demoBucketItems.filter { $0.is_experience == false }) { item in
                            ExperienceCard(item: item)
                        }
                    }
                    .padding([.bottom, .leading,. trailing])
                    .padding(.top, 8)
                }
            }
            .padding(.top, -10)
            // ///////////////////////////
            
            // Popular places
            VStack(alignment: .leading) {
                Text("Popular Experiences:")
                    .font(.headline)
                    .padding([.leading])
                    .padding(.top, 5)
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(demoBucketItems.filter { $0.is_experience == true }) { item in
                            ExperienceCard(item: item)
                        }
                    }
                    .padding([.bottom, .leading,. trailing])
                    .padding(.top, 8)
                }
            }
            .padding(.top, -10)
            // ///////////////////////////
            
            Text("Click below to create your own!")
                .padding([.leading, .trailing], 10)
                .frame(width: UIScreen.main.bounds.width, height: 100)
                .font(.headline)
                .foregroundColor(Color.white)
                .background(Color.blue.opacity(0.8))
            
        }
        .sheet(item: $selectedItem) { item in
            BucketItemDetailView(item: item)
        }
        .padding(.zero) // set padding to zero to remove any spacing around the ScrollView
        .edgesIgnoringSafeArea(.top) // ignore top safe area
    }
}

struct ExperienceCard: View {
    
    // Variables
    let item: BucketItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Image(photoPlaceholder)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
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

struct BucketItemRow: View {
    let item: BucketItem
    
    var body: some View {
        VStack(spacing: 0) {
            Image(photoPlaceholder)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
            
            HStack {
                Text(item.name)
                    .font(.system(size: 26))
                    .fontWeight(.semibold)
                
                Spacer()
            }
            
            HStack {
                Text(item.location)
                Spacer()
            }
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 30)
    }
}

struct ActivitiesView_Previews: PreviewProvider {
    static var previews: some View {
        ActivitiesView()
    }
}
