//
//  HomeView.swift
//  Bucket
//
//  Created by Nicholas Runje on 4/28/23.
//

import SwiftUI

struct HomeView: View {
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
            
            ForEach(Array(demoBucketItems.enumerated()), id: \.1) { index, item in
                ItemCard(item: item)
                
                if index != demoBucketItems.count - 1 {
                    ThreeDotsView()
                }
            }
            
        }
        .padding(.zero) // set padding to zero to remove any spacing around the ScrollView
        .edgesIgnoringSafeArea(.top) // ignore top safe area
    }
}

struct ItemCard: View {
    
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
                Text(item.title)
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
