//
//  CreateItemView.swift
//  Bucket
//
//  Created by Nicholas Runje on 5/5/23.
//

import SwiftUI

struct CreateItemView: View {
    @State private var name: String = ""
    @State private var location: String = ""
    @State private var date: String = ""
    @State private var note: String = ""
    @State private var photo: String = ""
    @State private var is_experience: Bool = false
    
    @Binding var isShowingView: Bool
    
    var body: some View {
        VStack {
            Group {
                VStack(alignment: .center, spacing: 16) {
                    Text("BucketList")
                            .font(.title2)
                            .fontWeight(.bold)
                    
                    VStack(alignment: .center, spacing: 16) {
                        
                        TextField("Enter activity name", text: $name)
                            .foregroundColor(.secondary)
                            .autocapitalization(.none)
                            .textCase(.lowercase)
                        
                        TextField("Enter location", text: $location)
                            .foregroundColor(.secondary)
                            .autocapitalization(.none)
                            .textCase(.lowercase)
                        
                        TextField("Enter date", text: $date)
                            .foregroundColor(.secondary)
                            .autocapitalization(.none)
                            .textCase(.lowercase)
                        
                        TextField("Enter personal note", text: $note)
                            .foregroundColor(.secondary)
                            .autocapitalization(.none)
                            .textCase(.lowercase)
                        
                        Toggle("Is Experience?", isOn: $is_experience)
                            .toggleStyle(SwitchToggleStyle(tint: .blue))
                    
                        Button {
                            // to do
                        } label: {
                            Text("Create account")
                                .padding(.top, 8)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
            }
            
            Spacer()
        }
    }
}

struct CreateItemView_Previews: PreviewProvider {
    static var previews: some View {
        CreateItemView(isShowingView: .constant(true))
    }
}

