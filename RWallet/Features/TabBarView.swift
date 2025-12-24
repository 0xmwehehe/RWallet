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
    
    @State var selection: MenuItem = .portfolio
    var body: some View {
        TabView {
            TabSection("Assets") {
                Tab("Tokens", systemImage: "chart.pie") {
                    TokenListView()
                }
                Tab("Defi", systemImage: "chart.pie") {
                    Text("portofolio")
                }
                Tab("Nft", systemImage: "chart.pie") {
                    Text("portofolio")
                }
            }
            
            TabSection("Trade") {
                Tab("Swap", systemImage: "chart.pie") {
                    Text("portofolio")
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
            
            Tab("Explore", systemImage: "network" ) {
                Text("portofolio")
            }
            
//            if UIDevice.current.userInterfaceIdiom != .phone {
//                TabSection("Account") {
//                    Tab("0x1341..dfs", systemImage: "wallet.bifold") {
//                        
//                    }
//                    
//                    Tab("0x1341..dfs", systemImage: "wallet.bifold.fill") {
//                        
//                    }
//                    
//                    Tab("0x1341..dfs", systemImage: "wallet.bifold.fill") {
//                        
//                    }
//                }
//                .tabPlacement(.sidebarOnly)
//            }
            Tab(role: .search) {
                
            }
        }
        .tabViewStyle(.sidebarAdaptable)
    }
}

#Preview {
    TabBarView()
}
