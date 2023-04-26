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
                    ForEach(demoBucketItems.filter { $0.typeOfActivity == .Experience }) { item in
                        VStack {
                            Image(photoPlaceholder)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: .infinity)
                            Text(item.title)
                        }
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
