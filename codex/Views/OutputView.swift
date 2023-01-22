//
//  OutputView.swift
//  codex
//
//  Created by Jaagrav Seal on 23/01/23.
//

import SwiftUI

struct OutputView: View {
    var codeOutput: CodeOutput
    
    var isLoading: Bool
    
    @Binding var showPopover: Bool
    
    var body: some View {
        HStack(alignment: .center) {
            Text("Output")
                .font(.largeTitle.bold())
            Spacer()
            Button("Cancel") {
                showPopover.toggle()
            }
            .bold()
            .foregroundColor(.red)
        }
        .padding(.horizontal, 16)
        .padding(.top, 32)
        
        if isLoading {
                ProgressView()
        }
        else {
            HStack {
                if codeOutput.output != nil {
                    Text(codeOutput.output!)
                        .multilineTextAlignment(.leading)
                } else if codeOutput.error != nil {
                    Text(codeOutput.error!)
                } else {
                    Text("No Ouput")
                }
                Spacer()
            }
            .padding(.top, 12)
            .padding(.horizontal, 16)
        }
        Spacer()
    }
}

struct OutputView_Previews: PreviewProvider {
    @State static var showPopover = true
    
    static var previews: some View {
        OutputView(codeOutput: CodeOutput(), isLoading: false, showPopover: $showPopover)
    }
}
