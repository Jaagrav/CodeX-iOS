//
//  RunAPI.swift
//  codex
//
//  Created by Jaagrav Seal on 23/01/23.
//

import SwiftUI

struct CodeOutput: Codable {
    var output: String?
    var error: String?
    var info: String?
    var status: Int?
}

class CodexAPI: ObservableObject {
    var apiURL = "https://api.codex.jaagrav.in"
    @Published var codeOutput: CodeOutput
    @Published var isLoading: Bool = false
    
    init() {
        self.codeOutput = CodeOutput()
    }

    func runCode(_ code: String, _ language: String, _ inputs: String) {
        guard let endpoint = URL(string: apiURL) else {
            return
        }
        
        let body: [String: Any] = ["code": code, "language": language, "inputs": inputs]
        
        let finalData = try! JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.httpBody = finalData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        self.isLoading = true
        URLSession.shared.dataTask(with: request) { data, _, _ in
            
            let output = try! JSONDecoder().decode(CodeOutput.self, from: data!)
            
            DispatchQueue.main.async {
                self.codeOutput = output
                self.isLoading = false
            }
        }
        .resume()
    }
}
