//
//  AppView.swift
//  codex
//
//  Created by Jaagrav Seal on 22/01/23.
//

import SwiftUI

struct AppView: View {
    @EnvironmentObject var codeList: CodeList
    
    var body: some View {
        ExplorerView()
            .onAppear() {
                codeList.getFromLS()
            }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
