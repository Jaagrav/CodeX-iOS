//
//  NewBit.swift
//  codex
//
//  Created by Jaagrav Seal on 22/01/23.
//

import SwiftUI

struct NewBit: View {
    @Binding var showPopover: Bool
    @EnvironmentObject var codeList: CodeList
    
    @State var newBitName = ""
    @State var newBitLanguageIndex = 1
    @State var showEmptyNameAlert = false
    
    var body: some View {
        HStack(alignment: .center) {
            Text("Create")
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
        
        VStack(alignment: .leading) {
            Text("Code Bit Name")
                .font(.subheadline.bold())
            TextField("e.g. Hello World", text: $newBitName)
                .font(.title)
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 16)
        
        HStack {
            Text("Language")
                .font(.subheadline.bold())
                .padding(.horizontal, 8)
            Spacer()
            Picker("Language", selection: $newBitLanguageIndex) {
                ForEach(codeList.supportedLanguages.indices, id: \.self) { index in
                    Text(codeList.supportedLanguages[index].title).tag(index)
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 8)
        
        Button {
            let supportedLanguage = codeList.supportedLanguages[newBitLanguageIndex]
            
            if newBitName != "" {
                codeList.createNewCodeBit(newBitName, supportedLanguage)
                showPopover.toggle()
            }
            else {
                showEmptyNameAlert.toggle()
            }
        }
        label: {
            Text("Create")
                .frame(maxWidth: .infinity)
        }
        .alert(isPresented: $showEmptyNameAlert) {
            Alert(title: Text("Error"), message: Text("Enter a title for your code bit dumbass!"), dismissButton: .default(Text("Oh crap right!")))
        }
        .font(.title2)
        .buttonStyle(.borderedProminent)
        .padding(20)
        .foregroundColor(.white)
        .tint(Color("themeColor"))
        
        Spacer()
    }
}

struct NewBit_Previews: PreviewProvider {
    @State static var showPopover = false
    static var previews: some View {
        NewBit(showPopover: $showPopover)
    }
}
