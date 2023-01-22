//
//  EditorView.swift
//  codex
//
//  Created by Jaagrav Seal on 22/01/23.
//

import SwiftUI
import CodeEditor

struct EditorView: View {
    @EnvironmentObject var codeList: CodeList
    var bitId: UUID
    
    @ObservedObject var codexApi = CodexAPI()
    @State var bitIndex = 0
    @State var code = ""
    @State var language = "py"
    @State var showOutput = false
    
    func initializeEditor() {
        for index in codeList.list.indices {
            if codeList.list[index].id == bitId {
                bitIndex = index
                break
            }
        }
        code = codeList.list[bitIndex].code
        language = codeList.list[bitIndex].language
    }
    
    func getEditorLanguage(_ language: String) -> CodeEditor.Language {
        switch language {
            case "java":
                return CodeEditor.Language.java
            case "py":
                return CodeEditor.Language.python
            case "c":
                return CodeEditor.Language.c
            case "cpp":
                return CodeEditor.Language.cpp
            case "js":
                return CodeEditor.Language.javascript
            case "go":
                return CodeEditor.Language.go
            case "cs":
                return CodeEditor.Language.cs
            default:
                return CodeEditor.Language.python
        }
    }
    
    func runCode() {
        if code != "" {
            codexApi.runCode(code, language, "")
            showOutput.toggle()
        }
    }
    
    var body: some View {
        VStack {
            CodeEditor(source: $code, language: getEditorLanguage(language), theme: CodeEditor.ThemeName.default)
                .onChange(of: code) { newCode in
                    codeList.list[bitIndex].code = newCode
                }
            HStack {
                Spacer()
                Picker("Language", selection: $language) {
                    ForEach(codeList.supportedLanguages) { supportedLanguage in
                        Text(supportedLanguage.title).tag(supportedLanguage.ext)
                    }
                }
                .onChange(of: language, perform: { changedLanguage in
                    var supportedLanguageIndex = 0
                    for i in codeList.supportedLanguages.indices {
                        if codeList.supportedLanguages[i].ext == changedLanguage {
                            supportedLanguageIndex = i
                            break
                        }
                    }
                    codeList.list[bitIndex].languageName = codeList.supportedLanguages[supportedLanguageIndex].title
                    codeList.list[bitIndex].language = changedLanguage
                })
                .pickerStyle(MenuPickerStyle())
                
                Button {
                    runCode()
                }
                label: {
                    Text("Run Code")
                }
                .buttonStyle(.borderedProminent)
                .foregroundColor(.white)
                .tint(Color("themeColor"))
                .popover(isPresented: $showOutput) {
                    OutputView(codeOutput: codexApi.codeOutput, isLoading: codexApi.isLoading, showPopover: $showOutput)
                        .onDisappear() {
                            codexApi.codeOutput = CodeOutput()
                        }
                }
                
            }
            .padding(12)
        }
        .onAppear(perform: self.initializeEditor)
    }
}

struct EditorView_Previews: PreviewProvider {
    static var previews: some View {
        EditorView(bitId: UUID())
    }
}
