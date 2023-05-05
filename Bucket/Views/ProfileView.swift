//
//  ProfileView.swift
//  Bucket
//
//  Created by Nicholas Runje on 4/28/23.
//

import SwiftUI

struct ProfileView: View {
    @State private var isEditing = false
    @State private var name = NetworkManager.name
    @State private var birthYear = NetworkManager.birth_year
    @EnvironmentObject var appEnvironment: AppEnvironment
    
    var body: some View {
        NavigationView {
            List {
                HStack {
                    Image(systemName: "person.circle")
                        .font(.system(size: 24))
                        .foregroundColor(.blue)
                    
                    Text("Name:")
                    
                    Spacer()
                    
                    if isEditing {
                        TextField("Enter your name", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                    } else {
                        Text(name)
                    }
                }
                
                HStack {
                    Image(systemName: "calendar.circle")
                        .font(.system(size: 24))
                        .foregroundColor(.blue)
                    
                    Text("Birth Year:")
                    
                    Spacer()
                    
                    if isEditing {
                        TextField("Enter your name", text: Binding(
                            get: { String(birthYear) },
                            set: { if let value = Int($0) { birthYear = value } }
                        ))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                    } else {
                        Text(String(birthYear))
                    }
                }
                
                
            }
            .navigationTitle("Profile")
            .navigationBarItems(
                trailing: Button(action: {
                    appEnvironment.signedIn = false
                }, label: {
                    Text("Logout")
                })
            )
            .onAppear {
//                name = NetworkManager.name
//                Vk
            }
        }
        
    }
    

}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
