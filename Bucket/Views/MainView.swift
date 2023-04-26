//
//  MainView.swift
//  Bucket
//
//  Created by Nicholas Runje on 4/25/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            Text("First View")
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("My Bucket")
                }
            
            ActivitiesView()
                .tabItem {
                    Image(systemName: "pencil")
                    Text("Activities")
                }
            
            Text("Third View")
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Profile")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
