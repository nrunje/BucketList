    //
    //  ProfileView.swift
    //  Bucket
    //
    //  Created by Nicholas Runje on 4/28/23.
    //

    import SwiftUI

    struct ProfileView: View {
        var body: some View {
            NavigationView {
                List {
                    HStack {
                        Image(systemName: "person.circle")
                            .font(.system(size: 24))
                            .foregroundColor(.blue)
                        
                        Text("Name:")
                        
                        Spacer()
                        
                        Text("John Adams")
                    }
                }
                .navigationTitle("Profile")
            }
        }
    }

    struct ProfileView_Previews: PreviewProvider {
        static var previews: some View {
            ProfileView()
        }
    }
