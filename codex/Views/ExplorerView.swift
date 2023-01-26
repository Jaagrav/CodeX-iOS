//
//  ExplorerView.swift
//  codex
//
//  Created by Jaagrav Seal on 22/01/23.
//

import SwiftUI

struct ExplorerView: View {
    @EnvironmentObject var codeList: CodeList
    @State var searchQuery = ""
    @State var showPopover = false
    
    var body: some View {
        HStack() {
            Text("CodeX")
                .font(.largeTitle.bold())
            Spacer()
            Button {
                showPopover.toggle()
            }
            label: {
                Image(systemName: "doc.fill.badge.plus")
                    .font(.title)
                    .foregroundColor(Color("themeColor"))
            }
            .popover(isPresented: $showPopover) {
                NewBit(showPopover: $showPopover)
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 48)
        
        TextField("Search", text: $searchQuery)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(UIColor.systemGray6))
            .clipShape(
                RoundedRectangle(cornerRadius: 10)
            )
            .padding(.horizontal, 16)
        
        List {
            ForEach(codeList.list) { bit in
                NavigationLink {
                    EditorView(bitId: bit.id)
                        .navigationTitle("\(bit.title).\(bit.language)")
                }
                label: {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(bit.title).\(bit.language)")
                                .font(.title2)
                            Text("Language: \(bit.languageName)")
                                .font(.footnote)
                            Text("Created on \(bit.timeStamp.formatted(date: .abbreviated, time: .shortened))")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .padding(.top, 6)
                                .multilineTextAlignment(.leading)
                        }
                        Spacer()
                        Image(bit.language)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .font(.largeTitle)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button {
                            codeList.removeCodeBit(bit.id)
                        } label: {
                            Image(systemName: "trash.fill")
                        }
                        .tint(.red)
                    }
                    .padding(.vertical, 6)
                }
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        Spacer()
    }
}

struct ExplorerView_Previews: PreviewProvider {
    static var previews: some View {
        ExplorerView()
    }
}
