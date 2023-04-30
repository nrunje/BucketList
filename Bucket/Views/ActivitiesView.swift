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
            
            VStack(spacing: 0) {
                ForEach(demoBucketItems.filter { $0.typeOfActivity == .Experience }) { item in
                    BucketItemRow(item: item)
                        .onTapGesture {
                            selectedItem = item
                        }
                    
                    if item != demoBucketItems.filter({ $0.typeOfActivity == .Experience }).last {
                        Divider()
                    }
                }
            }
            .background(Color.white)
            .cornerRadius(20)
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            
            Spacer()
        }
        .sheet(item: $selectedItem) { item in
            BucketItemDetailView(item: item)
        }
        .padding(.zero) // set padding to zero to remove any spacing around the ScrollView
        .edgesIgnoringSafeArea(.top) // ignore top safe area
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
