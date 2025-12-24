//
//  DefiListView.swift
//  RWallet
//
//  Created by Rendi  on 24/12/25.
//

import SwiftUI

struct DefiListView: View {
    @Environment(\.horizontalSizeClass) private var sizeClass
    @StateObject private var vm = DefiListViewModel()
    
    @State private var selectedPosition: DeFiPosition?
    @State private var searchText = ""
    
    // MARK: - Filtered Positions
    
    private var filteredPositions: [DeFiPosition] {
        guard !searchText.isEmpty else {
            return vm.positions
        }
        
        return vm.positions.filter { position in
            switch position {
            case .lending(let lending):
                return lending.protocolName.localizedCaseInsensitiveContains(searchText)
                
            case .liquidityPool(let pool):
                return pool.protocolName.localizedCaseInsensitiveContains(searchText)
                    || pool.pair.localizedCaseInsensitiveContains(searchText)
            
            case .locked(let locked):
                return locked.protocolName.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    // MARK: - Body
    
    var body: some View {
        if sizeClass == .regular {
            HStack(spacing: 0) {
                sidebarList
                    .frame(width: 320)
                    .background(Color(.systemBackground))
                
                Divider()
                    .ignoresSafeArea()
                
                detailView
                    .frame(maxWidth: .infinity)
            }
        } else {
            List(filteredPositions) { position in
                NavigationLink {
                    DefiDetailView(position: position)
                } label: {
                    DefiRowView(position: position)
                }
                .padding(.vertical,1)
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
    }
    
    // MARK: - Sidebar (iPad)
    
    private var sidebarList: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                ForEach(filteredPositions) { position in
                    DefiRowView(position: position)
                        .foregroundStyle(
                            selectedPosition?.id == position.id
                            ? Color(uiColor: .systemBackground)
                            : Color(uiColor: .label)
                        )
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(
                            selectedPosition?.id == position.id
                            ? Color.accentColor
                            : Color(uiColor: .systemBackground)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if selectedPosition?.id == position.id {
                                selectedPosition = nil
                            } else {
                                selectedPosition = position
                            }
                        }
                }
            }
            .padding()
        }
    }
    
    // MARK: - Detail
    
    @ViewBuilder
    private var detailView: some View {
        if let selectedPosition {
            DefiDetailView(position: selectedPosition)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        if sizeClass == .compact {
                            Button("Close") {
                                self.selectedPosition = nil
                            }
                        }
                    }
                }
        } else {
            emptyDetailView
        }
    }
    
    // MARK: - Empty State
    
    private var emptyDetailView: some View {
        ContentUnavailableView(
            "Select a DeFi Position",
            systemImage: "chart.pie",
            description: Text("Choose a lending or pool position from the sidebar")
        )
    }
}

struct DefiRowView: View {
    let position: DeFiPosition
    
    var body: some View {
        HStack(alignment:.center) {
            HStack(spacing:20){
                ImageOverlayView(
                    mainImage: Image(image),
                    overlayImage: Image(chain)
                )
                
                // Token info: name & symbol
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.headline)
                }
            }
            Spacer()
            Text("$ \(balance, specifier: "%.2f")")
                .font(.subheadline)
                .bold()
        }
    }

    private var image: String {
        switch position {
        case .lending(let lending):
            return "\(lending.image)"
        case .liquidityPool(let pool):
            return "\(pool.image)"
        case .locked(let locked):
            return "\(locked.image)"
        }
    }

    private var chain: String {
        switch position {
        case .lending(let lending):
            return "\(lending.chain)"
        case .liquidityPool(let pool):
            return "\(pool.chain)"
        case .locked(let locked):
            return "\(locked.chain)"
        }
    }

    private var title: String {
        switch position {
        case .lending(let lending):
            return "\(lending.protocolName)"
        case .liquidityPool(let pool):
            return "\(pool.protocolName)"
        case .locked(let locked):
            return "\(locked.protocolName)"
        }
    }
    
    private var subtitle: String {
        switch position {
        case .lending(let lending):
            return "Health: \(String(format: "%.2f", lending.healthRate))"
        case .liquidityPool(let pool):
            return pool.pair
        case .locked(let locked):
            return locked.lockId
        }
    }
    
    private var balance: Double {
        switch position {
        case .lending(let lending):
            return (lending.totalSuppliedUSD - lending.totalBorrowedUSD)
        case .liquidityPool(let pool):
            return pool.totalValueUSD
        case .locked(let locked):
            return locked.totalValueUSD
        }
    }
}

//struct DefiDetailView: View {
//    let position: DeFiPosition
//    
//    var body: some View {
//        VStack(spacing: 16) {
//            Text("DeFi Detail")
//                .font(.largeTitle)
//            
//            switch position {
//            case .lending(let lending):
//                Text("Protocol: \(lending.protocolName)")
//                Text("Health Rate: \(lending.healthRate)")
//                
//            case .liquidityPool(let pool):
//                Text("Protocol: \(pool.protocolName)")
//                Text("Pair: \(pool.pair)")
//            }
//        }
//        .padding()
//    }
//}

#Preview {
    NavigationStack{
        DefiListView()
    }
}
