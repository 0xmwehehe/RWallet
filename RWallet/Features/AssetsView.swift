//
//  AssetsView.swift
//  RWallet
//
//  Created by Rendi  on 24/12/25.
//

import SwiftUI

struct AssetsView: View {
//    @Binding var path: [WalletTab]
    @State var selectedTab: AssetsTab = .tokens
//
//    let mode: AssetsViewMode
    
    var body: some View {
        NavigationStack {
            tabbedContent
                .navigationDestination(for: TokenModel.self) {
                    TokenDetailView(token: $0)
                }
                .navigationDestination(for: NFTModel.self) {
                    NFTDetailView(token: $0)
                }
        }
    }
    
//    private var content: some View {
//        VStack(spacing: 0) {
//            switch mode {
//            case .tabbed:
//                tabbedContent
//
//            case .single(let tab):
//                singleContent(tab)
//            }
//        }
//        .onAppear {
//            if case .single(let tab) = mode {
//                selectedTab = tab
//            }
//        }
//    }
    
    private var tabbedContent: some View {
        VStack{
            PortfolioTabBar(selectedTab: $selectedTab)
            TabView(selection: $selectedTab) {
                TokenListView()
                    .tag(AssetsTab.tokens)
                
                DefiListView()
                    .tag(AssetsTab.defi)
                
                NFTListView()
                    .tag(AssetsTab.nfts)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
//
//    @ViewBuilder
//    private func singleContent(_ tab: AssetsTab) -> some View {
//        switch tab {
//        case .tokens:
//            TokenListView()
//
//        case .defi:
//            DefiListView()
//
//        case .nfts:
//            NFTListView()
//        }
//    }

}

struct PortfolioTabBar: View {
    @Binding var selectedTab: AssetsTab
    var body: some View {
        HStack {
            ForEach(AssetsTab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(.easeInOut) {
                        selectedTab = tab
                    }
                } label: {
                    VStack(spacing: 8) {
                        
                        Text(tab.rawValue)
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
        .background(Color(uiColor: .systemBackground))
    }
}

//#Preview {
//    AssetsView(selectedTab: .constant(.tokens))
//}
