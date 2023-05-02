//
//  ActivitiesView.swift
//  Bucket
//
//  Created by Nicholas Runje on 4/25/23.
//

import SwiftUI

struct ActivitiesView: View {
    @State private var selectedItem: BucketItem? = nil
    
    var body: some View {
        ScrollView {
            Rectangle()
                .fill(Color.blue.opacity(0.6))
                .frame(width: UIScreen.main.bounds.width, height: 150)
                .cornerRadius(10)
                .edgesIgnoringSafeArea(.top)
            
            Text("Popular Activities")
                .font(.system(size: 36))
                .fontWeight(.bold)
                .padding(.top, -70)
            
            // Popular places
            VStack(alignment: .leading) {
                Text("Popular Destinations:")
                    .font(.headline)
                    .padding([.leading])
                    .padding(.top, 5)
                
                ScrollView(.horizontal) {
                    HStack {
                        ExperienceCard(item: demoBucketItems[0])
                        ExperienceCard(item: demoBucketItems[0])
                        ExperienceCard(item: demoBucketItems[0])
                    }
                    .padding([.bottom, .leading,. trailing])
                    .padding(.top, 8)
                }
            }
            .padding(.top, -10)
            // ///////////////////////////
            
            // Popular places
            VStack(alignment: .leading) {
                Text("Popular Expereinces:")
                    .font(.headline)
                    .padding([.leading])
                    .padding(.top, 5)
                
                ScrollView(.horizontal) {
                    HStack {
                        ExperienceCard(item: demoBucketItems[0])
                        ExperienceCard(item: demoBucketItems[0])
                        ExperienceCard(item: demoBucketItems[0])
                    }
                    .padding([.bottom, .leading,. trailing])
                    .padding(.top, 8)
                }
            }
            .padding(.top, -10)
            // ///////////////////////////
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

struct BucketItemRow: View {
    let item: BucketItem
    
    var body: some View {
        VStack(spacing: 0) {
            Image(photoPlaceholder)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
            
            HStack {
                Text(item.title)
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
