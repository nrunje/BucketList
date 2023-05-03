//
//  ContentView.swift
//  Bucket
//
//  Created by Nicholas Runje on 4/25/23.
//

import SwiftUI

struct ContentView: View {
    @State private var signedIn = false
    
    var body: some View {
        Group {
            if signedIn {
                MainView()
            } else {
                CredentialPage(isSignedIn: $signedIn)
            }
        }
        .animation(.easeInOut(duration: 0.5), value: signedIn)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
