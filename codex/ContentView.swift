//
//  ContentView.swift
//  codex
//
//  Created by Jaagrav Seal on 22/01/23.
//

import SwiftUI

struct ContentView: View {    
    var body: some View {
        NavigationSplitView {
            AppView()
        }
        detail: {
            Text("No code bits opened")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
