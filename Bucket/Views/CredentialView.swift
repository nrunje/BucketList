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
                            
                            NetworkManager.shared.signIn(email: email, password: password) { token in
                                DispatchQueue.main.async {
                                    NetworkManager.session_token = token.session_token
                                }
                            }
                            
                        } label: {
                            Text("Sign in")
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
            .frame(width: UIScreen.main.bounds.width * 0.9, height: 300)
        .padding()
        }
    }
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

