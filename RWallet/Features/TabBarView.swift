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
//    @AppStorage("TabBarCustomization") private var customization: TabViewCustomization
    @Environment(\.horizontalSizeClass) private var sizeClass
    
    @State var selection: MenuItem = .portfolio
    var body: some View {
        TabView {
            if (sizeClass == .regular) {
                TabSection("Assets") {
                    Tab("Tokens", systemImage: "chart.pie") {
                        TokenListView()
                    }
                    Tab("Defi", systemImage: "chart.pie") {
                        DefiListView()
                    }
                    Tab("Nft", systemImage: "chart.pie") {
                        NavigationStack{
                            NFTListView()
                        }
                    }
                }
                
                TabSection("Trade") {
                    Tab("Swap", systemImage: "chart.pie") {
                        SendView()
                    }
                    Tab("Perps", systemImage: "chart.pie") {
                        Text("portofolio")
                    }
                }
                
                TabSection("Transactions") {
                    Tab("History", systemImage: "chart.pie") {
                        Text("portofolio")
                    }
                    Tab("Approvals", systemImage: "chart.pie") {
                        Text("portofolio")
                    }
                }
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
            Tab(role: .search) {
                
            }
        }
        .tabViewStyle(.sidebarAdaptable)
    }
}

#Preview {
    
    TabBarView()
}
