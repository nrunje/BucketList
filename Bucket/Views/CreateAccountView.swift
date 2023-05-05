//
//  CreateAccountView.swift
//  Bucket
//
//  Created by Nicholas Runje on 5/4/23.
//

import SwiftUI

struct CreateAccountView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var name: String = ""
    @State private var birth_year: String = ""
    
    @Binding var isShowingView: Bool
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    
    var body: some View {
        VStack {
            Group {
                VStack(alignment: .center, spacing: 16) {
                    Text("BucketList")
                            .font(.title2)
                            .fontWeight(.bold)
                    
                    VStack(alignment: .center, spacing: 16) {
                        
                        TextField("Enter email", text: $email)
                            .foregroundColor(.secondary)
                            .autocapitalization(.none)
                            .textCase(.lowercase)
                        
                        SecureField("Enter password", text: $password)
                            .foregroundColor(.secondary)
                            .autocapitalization(.none)
                            .textCase(.lowercase)
                        
                        TextField("Enter your name", text: $name)
                            .foregroundColor(.secondary)
                            .autocapitalization(.none)
                            .textCase(.lowercase)
                        
                        TextField("Year of birth", text: $birth_year)
                            .foregroundColor(.secondary)
                            .autocapitalization(.none)
                            .textCase(.lowercase)
                    
                        Button {
                            // Ensure birth_year is an integer before calling network manager
                            guard let birth_year = Int(birth_year) else {
                                alertTitle = "Error"
                                alertMessage = "Year of birth must be a number"
                                showAlert = true
                                return
                            }
                            
                            NetworkManager.shared.createAccount(email: email, password: password, name: name, birth_year: birth_year) { response in
                                DispatchQueue.main.async {
                                    switch response {
                                    case .success(_):
                                        alertTitle = "Success"
                                        alertMessage = "Successfully created account"
                                        isShowingView.toggle()
                                    case .failure(let error):
                                        alertTitle = "Error"
                                        alertMessage = error.localizedDescription
                                    }
                                    showAlert = true
                                }
                            }
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
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle),
                  message: Text(alertMessage),
                  dismissButton: .default(Text("OK")))
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView(isShowingView: .constant(true))
    }
}
