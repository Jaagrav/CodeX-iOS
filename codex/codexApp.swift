//
//  codexApp.swift
//  codex
//
//  Created by Jaagrav Seal on 22/01/23.
//

import SwiftUI

@main
struct codexApp: App {
    @State var codeList = CodeList()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(codeList)
        }
    }
}
