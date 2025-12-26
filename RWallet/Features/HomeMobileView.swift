//
//  HomeMobileView.swift
//  RWallet
//
//  Created by Rendi  on 24/12/25.
//

import SwiftUI

struct ActionMenu: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let icon: String
    let trailingText: String?
}
extension ActionMenu {
    var route: MenuTab {
        switch title {
        case "Swap": return .swap
        case "Send": return .send
        case "Perps": return .perps
        case "Transactions": return .history
        case "Approvals": return .approval
        default: return .history
        }
    }
}

enum HomeRoute: Hashable {
    case swap
    case send
    case receive
    case bridge
    case perps
    case lending
    case transactions
    case approvals
    case gasAccount
    case watchlist
}


struct HomeMobileView: View {
    @Binding var path: [WalletTab]
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    let menus: [ActionMenu] = [
        .init(title: "Swap", icon: "arrow.left.arrow.right", trailingText: nil),
        .init(title: "Send", icon: "paperplane.fill", trailingText: nil),
        .init(title: "Receive", icon: "tray.and.arrow.down.fill", trailingText: nil),
        .init(title: "Bridge", icon: "headphones", trailingText: nil),
        .init(title: "Perps", icon: "gamecontroller", trailingText: "<$0.01"),
        .init(title: "Lending", icon: "person.2.fill", trailingText: nil),
        .init(title: "Rabby Points", icon: "sparkles", trailingText: nil),
        .init(title: "Transactions", icon: "clock.fill", trailingText: nil),
        .init(title: "Approvals", icon: "checkmark.shield.fill", trailingText: nil),
        .init(title: "GasAccount", icon: "dollarsign.circle.fill", trailingText: "$0.92"),
        .init(title: "Token Watchlist", icon: "eye.fill", trailingText: nil)
    ]
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                headerView
                
                LazyVGrid(columns: columns) {
                    ForEach(MenuTab.allCases, id:\.self) { tab in
                        NavigationLink(value: WalletTab.menu(tab)) {
                            ActionCard(menu: tab)
                        }
                    }
                }
                .padding()
            }
            .background(Color(uiColor: .secondarySystemBackground))
            .navigationDestination(for: WalletTab.self) { tab in
                tab.detailTab()
            }
        }
    }
    
    private var headerView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("$17,500")
                    .font(.title)
                    .bold()
                Text("+1.17% (+200.94)")
                    .font(.caption)
                    .foregroundColor(.green)
            }
            
            Spacer()
            
            HStack {
                Image(systemName: "wallet.bifold.fill")
                Text("1")
                    .bold()
            }
            .padding(.horizontal)
            .padding(.vertical, 14)
            .foregroundStyle(.background)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color(uiColor: .label))
            )
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(uiColor: .systemBackground))
        )
        .padding(.horizontal)
    }
}

struct ActionCard: View {
    let menu: MenuTab
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            HStack {
                Image(systemName: menu.icon)
                    .font(.title2)
                    .foregroundColor(.blue)
                
                Spacer()
                
//                if let trailing = menu.trailingText {
//                    Text(trailing)
//                        .font(.caption)
//                        .foregroundColor(.gray)
//                }
            }
            
            Spacer()
            
            Text(menu.title)
                .font(.headline)
                .foregroundColor(.primary)
        }
        .padding()
        .frame(height: 110)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
        )
    }
}

struct ActionDetailView: View {
    let menu: ActionMenu
    
    var body: some View {
        VStack(spacing: 16) {
            Text("MOMO")
                .font(.largeTitle)
                .bold()
            
            Text(menu.title)
                .foregroundColor(.secondary)
        }
        .navigationTitle(menu.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}


//#Preview {
//    HomeMobileView(path: .constant(.history))
//}
