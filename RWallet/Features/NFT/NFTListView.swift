//
//  NFTListView.swift
//  RWallet
//
//  Created by Rendi  on 24/12/25.
//

import SwiftUI

struct NFTListView: View {
    @Environment(\.horizontalSizeClass) private var sizeClass
    @StateObject private var vm = NFTViewModel()
    @State private var searchText = ""
    @State private var selectedNFT: NFTModel?
    
    var body: some View {
        if (sizeClass == .regular) {
            nftGrid(columns: 4, isSelectable: true)
                .fullScreenCover(item: $selectedNFT) { nft in
                    ZStack {
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .ignoresSafeArea()
                            .onTapGesture {
                                selectedNFT = nil
                            }
                        
                        VStack {
                            NFTDetailView(token: nft)
                                .padding()
                        }
                        .frame(
                            maxWidth: UIScreen.main.bounds.width * 0.75,
                            maxHeight: UIScreen.main.bounds.height * 0.75
                        )
                        .background(
                            RoundedRectangle(cornerRadius: 28, style: .continuous)
                                .fill(Color(uiColor: .systemBackground))
                        )
                        .clipShape(
                            RoundedRectangle(cornerRadius: 28, style: .continuous)
                        )
                        .shadow(radius: 30)
                    }
                    .presentationBackground(.clear)
                }
        } else {
            nftGrid(columns: 2, isSelectable: false)
        }
    }
    
    // MARK: - Grid
    private func nftGrid(columns: Int, isSelectable: Bool) -> some View {
        let grid = Array(
            repeating: GridItem(.flexible(), spacing: 16),
            count: columns
        )
        
        return ScrollView {
            LazyVGrid(columns: grid, spacing: 16) {
                ForEach(filteredTokens, id: \.self) { item in
                    nftCard(item, isSelectable: isSelectable)
                }
            }
            .padding(16)
        }
    }
    private func nftCard(
        _ item: NFTModel,
        isSelectable: Bool
    ) -> some View {
        Group {
            if isSelectable {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.secondarySystemFill))
                    .aspectRatio(1, contentMode: .fit)
                    .overlay(
                        Text(item.name)
                            .foregroundColor(.white)
                    )
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if isSelectable {
                            selectedNFT = item
                        }
                    }
            } else {
                NavigationLink(value: item) {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.secondarySystemFill))
                        .aspectRatio(1, contentMode: .fit)
                        .overlay(
                            Text(item.name)
                                .foregroundColor(.primary)
                        )
                }
            }
            
        }
    }
    // MARK: - Filter
    private var filteredTokens: [NFTModel] {
        searchText.isEmpty
        ? vm.tokens
        : vm.tokens.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }
}

#Preview {
    //    TabBarView()
    NavigationStack{
        NFTListView()
            .navigationDestination(for: NFTModel.self) {
                NFTDetailView(token: $0)
            }
    }
}
