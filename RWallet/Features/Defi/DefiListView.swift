//
//  DefiListView.swift
//  RWallet
//
//  Created by Rendi  on 24/12/25.
//

import SwiftUI

struct DefiListView: View {
    @Environment(\.horizontalSizeClass) private var sizeClass
    @StateObject private var vm = TokenListViewModel()
    @State private var selectedToken: TokenModel?
    @State private var searchText = ""
    
    private var filteredTokens: [TokenModel] {
        searchText.isEmpty
        ? vm.tokens
        : vm.tokens.filter {
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.symbol.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        if sizeClass == .regular {
            NavigationStack {
                HStack(spacing: 0) {
                    sidebarList
                        .frame(width: 320)
                        .background(Color(.systemBackground))
                    
                    Divider()
                        .ignoresSafeArea()
                    
                    detailView
                        .frame(maxWidth: .infinity)
                }
            }
        } else {
            List(filteredTokens) { token in
                NavigationLink(value: token) {
                    TokenRowView(token: token)
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
    }
    
    private var sidebarList: some View {
        ScrollView {
            LazyVStack {
                ForEach(filteredTokens) { token in
                    TokenRowView(token: token)
                        .foregroundStyle(selectedToken == token ?
                                         Color(uiColor: .systemBackground) :
                                            Color(uiColor: .label))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(
                            selectedToken == token ?
                            Color.accentColor :
                                Color(uiColor: .systemBackground)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    //                        .padding(.horizontal)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if selectedToken == token {
                                selectedToken = nil
                            } else {
                                selectedToken = token
                            }
                        }
                }
            }
            .padding()
        }
    }
    
    @ViewBuilder
    private var detailView: some View {
        if let selectedToken {
            TokenDetailView(token: selectedToken)
                .toolbar {
                    // Tambahkan close button jika perlu
                    ToolbarItem(placement: .navigationBarLeading) {
                        if sizeClass == .compact {
                            Button("Close") {
                                self.selectedToken = nil
                            }
                        }
                    }
                }
        } else {
            emptyDetailView
        }
    }
    
    private var emptyDetailView: some View {
        ContentUnavailableView(
            "Select a Token",
            systemImage: "bitcoinsign.circle",
            description: Text("Choose a token from the sidebar")
        )
    }
}

#Preview {
    DefiListView()
}
