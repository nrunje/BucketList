//
//  ActivitiesView.swift
//  Bucket
//
//  Created by Nicholas Runje on 4/25/23.
//

import SwiftUI

struct ActivitiesView: View {
    var body: some View {
        
        NavigationView {
            List {
                // Experiences
                Section(header: Text("Experiences")) {
                    
                    // Loop over the items
                    ForEach(demoBucketItems.filter { $0.typeOfActivity == .Experience }) { item in
                        // Each individual line
                        
                        NavigationLink(destination: BucketItemDetailView(item: item)) {
                            VStack {
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
                        }
                        // // // // // // // // //
                    }
                }
                
                // Locations
                Section(header: Text("Locations")) {
                    ForEach(demoBucketItems.filter { $0.typeOfActivity == .Location }) { item in
                        Text(item.title)
                    }
                }
            }
            .navigationTitle("Popular Activities")
        }
        
    }
    
    
}

struct ActivitiesView_Previews: PreviewProvider {
    static var previews: some View {
        ActivitiesView()
    }
}
