//
//  CodeList.swift
//  codex
//
//  Created by Jaagrav Seal on 22/01/23.
//

import Foundation

struct SupportedLanguage: Identifiable {
    var title: String
    var ext: String
    var id = UUID()
}

struct CodeBit: Codable, Identifiable {
    var title: String
    var language: String
    var languageName: String
    var id = UUID()
    var code: String
    var timeStamp = Date.now
}

class CodeList: ObservableObject {
    @Published var list = [
        CodeBit(title: "Hello World", language: "py", languageName: "Python", code: ""),
        CodeBit(title: "Palindrome", language: "java", languageName: "Java", code: "")
    ]
    
    @Published var supportedLanguages = [
        SupportedLanguage(title: "Java", ext: "java"),
        SupportedLanguage(title: "Python", ext: "py"),
        SupportedLanguage(title: "C Language", ext: "c"),
        SupportedLanguage(title: "C++", ext: "cpp"),
        SupportedLanguage(title: "JavaScript", ext: "js"),
        SupportedLanguage(title: "Go Lang", ext: "go"),
        SupportedLanguage(title: "C#", ext: "cs"),
    ]
    
    func createNewCodeBit(_ title: String, _ supportedLanguage: SupportedLanguage) {
        list.append(
            CodeBit(title: title, language: supportedLanguage.ext, languageName: supportedLanguage.title, code: "")
        )
        storeInLS()
    }
    
    func removeCodeBit(_ id: UUID) {
        var index = -1
        
        for i in list.indices {
            if list[i].id == id {
                index = i
                break
            }
        }
        
        list.remove(at: index)
        storeInLS()
    }
    
    func storeInLS() {
        do {
            let jsonData = try JSONEncoder().encode(self.list)

            UserDefaults.standard.set(jsonData, forKey: "codeList")
        } catch {
            print(error)
        }
    }
    
    func getFromLS() {
        do {
            let lsValue = UserDefaults.standard.data(forKey: "codeList") ?? Data()
            let data = try JSONDecoder().decode([CodeBit].self, from: lsValue)

            self.list = data

        } catch {
            print(error)
        }
    }
}
