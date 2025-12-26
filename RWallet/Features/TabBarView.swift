//
//  TabBarView.swift
//  RWallet
//
//  Created by Rendi  on 24/12/25.
//

import SwiftUI

enum WalletTab: Hashable, Identifiable {
    case asset(AssetsTab)
    case menu(MenuTab)
    case setting
    case explore
    case home
    
    var id: String {
        switch self {
        case .asset(let tab): return "asset-\(tab.rawValue)"
        case .menu(let tab): return "menu-\(tab.rawValue)"
        case .setting: return "setting"
        case .explore: return "explore"
        case .home: return "home"
        }
    }
    
    var showInHomeTabBar: Bool {
        switch self {
        case .menu: return true
        default: return false
        }
    }
    
    var showInAssetTab: Bool {
        if case .asset = self {
            return true
        } else {
            return false
        }
    }
    
    @ViewBuilder
    func detailTab() -> some View {
        switch self {
        case .asset(let tab): tab.detailAssetTab()
        case .menu(let tab): tab.detailMenuTab()
        case .setting: Text("Setting")
        case .explore: BrowserView()
        case .home: Text("Home")
        }
    }
}

enum AssetsViewMode: Equatable {
    case tabbed
    case single(AssetsTab)
}

enum AssetsTab: String, Hashable, CaseIterable, Identifiable {
    case tokens = "Tokens"
    case defi = "DeFi"
    case nfts = "NFT"
    
    var id : String {
        rawValue
    }
    
    @ViewBuilder
    func detailAssetTab() -> some View {
        switch self {
        case .tokens: TokenListView()
        case .defi: DefiListView()
        case .nfts: NFTListView()
        }
    }
}

enum MenuTab: String, Hashable, CaseIterable {
    case perps = "Perps"
    case swap = "Swap"
    case send = "Send"
    case history = "History"
    case approval = "Approval"
    
    var title: String {
        rawValue
    }
    var icon: String {
        switch self {
        case .perps: "line.horizontal.3.circle"
        case .swap: "square.and.arrow.up"
        case .send: "arrow.triangle.2.circlepath"
        case .history: "list.bullet"
        case .approval: "lock.shield"
        }
    }
    
    @ViewBuilder
    func detailMenuTab() -> some View {
        switch self {
        case .perps: Text("Perps")
        case .swap: SwapView()
        case .send: SendView()
        case .history: TransactionView()
        case .approval: ApprovalView()
        }
    }
}

struct TabBarView: View {
    @AppStorage("TabBarCustomization") private var customization: TabViewCustomization
    @Environment(\.horizontalSizeClass) private var sizeClass
    
    @StateObject private var vm = TabViewModel()
    var body: some View {
        TabView(selection: $vm.selectedTab) {
            Tab("Setting", systemImage: "gear", value: .setting) {
                Text("Settings")
            }
            .customizationID("Tab.Setting")
            
            Tab("Explore", systemImage: "network", value: .explore) {
                BrowserView()
            }
            .customizationID("Tab.Explore")
            
            Tab("Asset", systemImage: "square.stack", value: .asset(.tokens)){
                AssetsView()
            }
            
            Tab("History", systemImage: "clock", value: .menu(.history)){
                TransactionView()
            }
            .hidden(sizeClass == .compact)
            
            Tab("Approval", systemImage: "list.bullet", value: .menu(.approval)){
                ApprovalView()
            }
            .hidden(sizeClass == .compact)
            
            Tab("Home", systemImage: "hare", value: .home) {
                HomeMobileView(path: $vm.homeTabPath)
            }
            .hidden(sizeClass != .compact)
            
        }
        .tabViewStyle(.sidebarAdaptable)
        .tabViewCustomization($customization)
        .onChange(of: sizeClass) { oldValue, newValue in
            vm.adaptForCompact(sizeClass: newValue)
        }
    }
}

#Preview {
    
    TabBarView()
}


final class TabViewModel: ObservableObject {
    @Published var selectedTab: WalletTab = .setting
    @Published var homeTabPath: [WalletTab] = []
    
    func adaptForCompact(
        sizeClass: UserInterfaceSizeClass?)
    {
        if sizeClass == .compact && selectedTab.showInHomeTabBar {
            homeTabPath = [selectedTab]
        } else if sizeClass == .regular && selectedTab.showInHomeTabBar {
            let selected = selectedTab
            selectedTab = homeTabPath.last ?? selected
        }
    }
}
