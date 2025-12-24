//
//  AssetsView.swift
//  RWallet
//
//  Created by Rendi  on 24/12/25.
//

import SwiftUI

enum PortfolioSubItem: String, CaseIterable, Identifiable, Hashable {
    case tokens = "Tokens"
    case defi = "DeFi"
    case nfts = "NFTs"
    case transactions = "Transactions"
    case approval = "Approval"
    
    var id: String { rawValue }
    
    var title: String {
        switch self {
        case .tokens: return "Tokens"
        case .defi: return "DeFi"
        case .nfts: return "NFTs"
        case .transactions: return "Transactions"
        case .approval: return "Approval"
        }
    }
    
    var iconName: String {
        switch self {
        case .tokens: return "dollarsign.circle"
        case .defi: return "link.circle"
        case .nfts: return "photo.circle"
        case .transactions: return "arrow.right.arrow.left.circle"
        case .approval: return "checkmark.circle"
        }
    }
}

struct AssetsView: View {
    @State private var selectedTab: PortfolioSubItem = .tokens
    
    var body: some View {
        NavigationStack {
            content
                .navigationDestination(for: TokenModel.self) {
                    TokenDetailView(token: $0)
                }
                .navigationDestination(for: NFTModel.self) {
                    NFTDetailView(token: $0)
                }
        }
    }
    
    private var content: some View {
        VStack(spacing: 0) {
            PortfolioTabBar(selectedTab: $selectedTab)
            
            TabView(selection: $selectedTab) {
                TokenListView()
                    .tag(PortfolioSubItem.tokens)
                DefiListView()
                    .tag(PortfolioSubItem.defi)
                NFTListView()
                    .tag(PortfolioSubItem.nfts)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
}

struct PortfolioTabBar: View {
    
    @Binding var selectedTab: PortfolioSubItem
    
    var body: some View {
        HStack {
            ForEach(PortfolioSubItem.allCases.prefix(3), id: \.self) { tab in
                Button {
                    withAnimation(.easeInOut) {
                        selectedTab = tab
                    }
                } label: {
                    VStack(spacing: 8) {
                        
                        Text(tab.title)
                            .font(.headline)
                            .foregroundColor(
                                selectedTab == tab ? Color.accentColor : .gray
                            )
                        
                        // Underline
                        Rectangle()
                            .fill(selectedTab == tab ? Color.accentColor : Color.clear)
                            .frame(height: 2)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    AssetsView()
}
