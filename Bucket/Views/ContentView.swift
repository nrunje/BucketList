//
//  ContentView.swift
//  Bucket
//
//  Created by Nicholas Runje on 4/25/23.
//

import SwiftUI

class AppEnvironment: ObservableObject {
    @Published var signedIn: Bool = false
}

struct ContentView: View {
    @StateObject var appEnvironment = AppEnvironment()
    
    var body: some View {
        Group {
            if appEnvironment.signedIn {
                MainView()
            } else {
                CredentialPage()
            }
        }
        .animation(.easeInOut(duration: 0.5), value: appEnvironment.signedIn)
        .environmentObject(appEnvironment)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
