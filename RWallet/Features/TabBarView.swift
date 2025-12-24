//
//  TabBarView.swift
//  RWallet
//
//  Created by Rendi  on 24/12/25.
//

import SwiftUI

enum MenuItem: String, CaseIterable, Identifiable, Hashable {
    case portfolio = "Portfolio"
    case perps = "Perps"
    case browser = "Browser"
    
    var id: String { rawValue }
    
    var iconName: String {
        switch self {
        case .portfolio: return "chart.pie.fill"
        case .perps: return "bitcoinsign.circle.fill"
        case .browser: return "network"
        }
    }
}

struct TabBarView: View {
    @AppStorage("TabBarCustomization") private var customization: TabViewCustomization
    @Environment(\.horizontalSizeClass) private var sizeClass
    
    @State var selection: MenuItem = .portfolio
    var body: some View {
        TabView {
            if (sizeClass == .regular) {
                TabSection("Assets") {
                    Tab("Tokens", systemImage: "bitcoinsign.circle") {
                        TokenListView()
                    }
                    .customizationID("Tab.Tokens")
                    Tab("Defi", systemImage: "cube.transparent") {
                        DefiListView()
                    }
                    .customizationID("Tab.Defi")
                    Tab("Nft", systemImage: "text.below.photo") {
                        NavigationStack{
                            NFTListView()
                        }
                    }
                    .customizationID("Tab.NFT")
                }
                
                TabSection("Trade") {
                    Tab("Swap", systemImage: "arrow.left.arrow.right") {
                        SendView()
                    }
                    .customizationID("Tab.Swap")
                    Tab("Perps", systemImage: "gamecontroller") {
                        Text("portofolio")
                    }
                    .customizationID("Tab.Perps")
                }
                .customizationID("Tab.Trade")
                
                TabSection("Transactions") {
                    Tab("History", systemImage: "clock") {
                        TransactionView()
                    }
                    .customizationID("Tab.History")
                    Tab("Approvals", systemImage: "checkmark.shield") {
                        ApprovalView()
                    }
                    .customizationID("Tab.Approval")
                }
                .customizationID("Tab.Transactions")
            } else {
                Tab("Rabby", systemImage: "hare" ) {
                    HomeMobileView()
                }
                Tab("Assets", systemImage: "wallet.bifold" ) {
                    AssetsView()
                }
            }
            
            Tab("Explore", systemImage: "network" ) {
                BrowserView()
            }
            .customizationID("Tab.Explore")
            Tab(role: .search) {
                
            }
        }
        .tabViewStyle(.sidebarAdaptable)
        .tabViewCustomization($customization)
    }
}

#Preview {
    
    TabBarView()
}
