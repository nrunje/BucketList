//
//  ContentView.swift
//  Bucket
//
//  Created by Nicholas Runje on 4/25/23.
//

import SwiftUI

struct ContentView: View {
    @State private var signedIn = true
    
    var body: some View {
        Group {
//            if signedIn {
                MainView()
//            } else {
//                SignInView()
//            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
