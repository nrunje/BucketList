//
//  CredentialPage.swift
//  Bucket
//
//  Created by Nicholas Runje on 5/2/23.
//

import SwiftUI

struct CredentialPage: View {
    @State private var offsetX: CGFloat = 0
    @State private var email: String = ""
    @State private var password: String = ""
    @Binding var isSignedIn: Bool
    @State private var showingAlert = false
    @State private var isShowingCreateAccount = false
    
    var body: some View {
        ZStack {
            Image("nature")
                .resizable()
                .scaledToFill()
//                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .clipped()
                .offset(x: offsetX)
                .animation(Animation.linear(duration: 15).repeatForever(autoreverses: true))
                .onAppear {
                    self.offsetX = -UIScreen.main.bounds.width / 2
                }
                .scaleEffect(1.2)
    
                
            Blur(style: .systemUltraThinMaterial)
                .edgesIgnoringSafeArea(.all)
                .opacity(0.7)
            
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
                    
                        Button {
//                            isSignedIn.toggle()
                            let email = email
                            let password = password
                            print("email is: \(email) and password is: \(password)")
                            
                            NetworkManager.shared.signIn(email: email, password: password) { result in
                                DispatchQueue.main.async {
                                    switch result {
                                    case .success(let token):
                                        NetworkManager.session_token = token.session_token
                                        isSignedIn.toggle()
                                    case .failure(let error):
                                        print(error.localizedDescription)
                                        // Show a popup with the error message
                                        DispatchQueue.main.async {
                                            showingAlert = true
                                        }
                                    }
                                }
                            }
                            
                        } label: {
                            Text("Sign in")
                                .padding(.top, 8)
                        }
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Incorrect email or password"),
                                  message: Text("Please try again."),
                                  dismissButton: .default(Text("OK")))
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
            }
            .frame(width: UIScreen.main.bounds.width * 0.9, height: 300)
            .padding()
            
            VStack(alignment: .trailing) {
                Spacer()
                
                Button {
                    isShowingCreateAccount = true
                } label: {
                    Text("Create Account")
                        .foregroundColor(Color.white)
                }
                .padding(.bottom, 15)
            }
        }
        .sheet(isPresented: $isShowingCreateAccount) {
            CreateAccountView(isShowingView: $isShowingCreateAccount) // show CreateAccountView as a sheet
        }
        // End ZStack
    }
    // End body
    
    
}

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial

    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

struct CredentialPage_Previews: PreviewProvider {
    static var previews: some View {
        CredentialPage(isSignedIn: .constant(false))
    }
}

