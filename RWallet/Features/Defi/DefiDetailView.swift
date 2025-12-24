//
//  DefiDetailView.swift
//  RWallet
//
//  Created by Rendi  on 24/12/25.
//

import SwiftUI

// MARK: - DeFi Detail View

struct DefiDetailView: View {
    let position: DeFiPosition
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                headerSection
                
                switch position {
                case .lending(let lending):
                    lendingSection(lending)
                    
                case .liquidityPool(let pool):
                    liquidityPoolSection(pool)
                    
                case .locked(let locked):
                    lockedSection(locked)
                }
            }
            .padding()
        }
        .background(Color(.systemBackground))
    }
}

// MARK: - Header

private extension DefiDetailView {
    
    var headerSection: some View {
        HStack(spacing: 12) {
            ProtocolIcon(image: protocolImage, chain: protocolChain)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(protocolName)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text(categoryTitle)
                    .font(.caption)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Color.secondary.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            Spacer()
            
            Text(totalValueUSD)
                .font(.title2)
                .fontWeight(.semibold)
        }
    }
    
    var protocolName: String {
        switch position {
        case .lending(let l): return l.protocolName
        case .liquidityPool(let p): return p.protocolName
        case .locked(let l): return l.protocolName
        }
    }
    
    var protocolImage: String {
        switch position {
        case .lending(let l): return l.image
        case .liquidityPool(let p): return p.image
        case .locked(let l): return l.image
        }
    }
    
    var protocolChain: String {
        switch position {
        case .lending(let l): return l.chain.rawValue
        case .liquidityPool(let p): return p.chain.rawValue
        case .locked(let l): return l.chain.rawValue
        }
    }
    
    var categoryTitle: String {
        switch position.category {
        case .lending: return "Lending"
        case .liquidityPool: return "Liquidity Pool"
        case .locked: return "Locked"
        case .staking: return "Staking"
        case .farming: return "Farming"
        }
    }
    
    var totalValueUSD: String {
        let value: Double
        switch position {
        case .lending(let l):
            value = l.totalSuppliedUSD - l.totalBorrowedUSD
        case .liquidityPool(let p):
            value = p.totalValueUSD
        case .locked(let l):
            value = l.totalValueUSD
        }
        return value.formatted(.currency(code: "USD"))
    }
}

// MARK: - Lending Section

private extension DefiDetailView {
    
    func lendingSection(_ lending: LendingPosition) -> some View {
        VStack(spacing: 16) {
            
            infoRow(
                title: "Health Rate",
                value: String(format: "%.2f", lending.healthRate)
            )
            .cardStyle()
            
            tokenListSection(
                title: "Supplied",
                tokens: lending.supplied
            )
            .cardStyle()
            
            if (!lending.borrowed.isEmpty) {
                tokenListSection(
                    title: "Borrowed",
                    tokens: lending.borrowed
                )
                .cardStyle()
            }
        }
    }
}

// MARK: - Liquidity Pool Section

private extension DefiDetailView {
    
    func liquidityPoolSection(_ pool: LiquidityPoolPosition) -> some View {
        VStack(spacing: 16) {
            
            VStack {
                infoRowImage(title: "Pool", value: pool.tokens)
                infoRow(title: "APR", value: "\(pool.apr)%")
            }
            .cardStyle()
            
            tokenListSection(
                title: "Balance",
                tokens: pool.tokens
            )
            .cardStyle()
            
            if !pool.rewards.isEmpty {
                tokenListSection(
                    title: "Rewards",
                    tokens: pool.rewards,
                    showClaim: true
                )
                .cardStyle()
            }
        }
    }
}

// MARK: - Locked Section

private extension DefiDetailView {
    
    func lockedSection(_ locked: LockedTokenPosition) -> some View {
        VStack(spacing: 16) {
            
            VStack(spacing: 8) {
                infoRow(title: "Lock ID", value: locked.lockId)
                infoRow(
                    title: "Unlock",
                    value: locked.unlockTime.formatted(date: .abbreviated, time: .shortened)
                )
            }
            .cardStyle()
            
            tokenListSection(
                title: "Locked Token",
                tokens: [locked.lockedToken]
            )
            .cardStyle()
            
            if !locked.rewards.isEmpty {
                VStack(spacing: 12) {
                    Text("Rewards")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ForEach(locked.rewards) { reward in
                        VStack(spacing: 8) {
                            infoRow(title: "Pool", value: reward.pair)
                            
                            ForEach(reward.tokens) { token in
                                HStack {
                                    TokenIcon(symbol: token.symbol)
                                    
                                    VStack(alignment: .leading) {
                                        Text(token.symbol)
                                        Text(token.amount.formatted())
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    Spacer()
                                    
                                    Text(
                                        token.valueUSD.formatted(.currency(code: "USD"))
                                    )
                                }
                            }
                            
                            Button("Claim") {}
                                .buttonStyle(.borderedProminent)
                                .tint(.orange)
                                .frame(maxWidth: .infinity)
                        }
                        .cardStyle()
                    }
                }
            }
        }
    }
}

// MARK: - Reusable Sections

private extension DefiDetailView {
    
    func tokenListSection(
        title: String,
        tokens: [TokenAmount],
        showClaim: Bool = false
    ) -> some View {
        VStack(spacing: 12) {
            
            HStack {
                Text(title)
                    .font(.headline)
                Spacer()
            }
            Divider()
            
            ForEach(tokens) { token in
                HStack {
                    TokenIcon(symbol: token.symbol)
                    
                    VStack(alignment: .leading) {
                        Text(token.symbol)
                            .fontWeight(.medium)
                        Text(token.amount.formatted())
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text(token.valueUSD.formatted(.currency(code: "USD")))
                            .fontWeight(.medium)
                        
                        if showClaim {
                            Button("Claim") {}
                                .font(.caption)
                                .buttonStyle(.borderedProminent)
                                .tint(.orange)
                        }
                    }
                }
                .padding(.vertical, 6)
            }
        }
    }
    
    func infoRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.medium)
        }
    }
    
    func infoRowImage(title: String, value: [TokenAmount]) -> some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.secondary)
            Spacer()
            OverlappingImagesView(
                images: value.prefix(2).map {
                    Image($0.symbol.lowercased())
                },
                size: 24
            )
        }
    }
}

// MARK: - UI Components

struct TokenIcon: View {
    let symbol: String
    let size: CGFloat = 28
    
    var body: some View {
        Image(symbol.lowercased())
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .clipShape(Circle())
            .overlay(
                Circle().stroke(Color.secondary.opacity(0.2), lineWidth: 1)
            )
    }
}

struct ProtocolIcon: View {
    let image: String
    let chain: String
    let size: CGFloat = 42
    
    var body: some View {
        Image(image)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.secondary.opacity(0.3), lineWidth: 1)
            )
            .overlay(
                Image(chain)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 16, height: 16)
                    .clipShape(Circle()),
                alignment: .bottomTrailing
            )
    }
}

// MARK: - Card Style

private extension View {
    func cardStyle() -> some View {
        self
            .padding()
            .background(Color(.secondarySystemBackground))
            .clipShape(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
            )
    }
}


#Preview {
//    DefiDetailView(position: .liquidityPool(
//        LiquidityPoolPosition(
//            protocolName: "Aerodrome",
//            chain: .arb,
//            image: "aero",
//            url: "https://aave.com/",
//            pair: "ETH / USDC",
//            tokens: [
//                TokenAmount(symbol: "ETH", amount: 1.2, priceUSD: 1800),
//                TokenAmount(symbol: "USDC", amount: 2100, priceUSD: 1)
//            ],
//            poolShare: 0.015,
//            apr: 24.6,
//            impermanentLossUSD: -120,
//            rewards: [
//                TokenAmount(symbol: "AERO", amount: 85, priceUSD: 0.78)
//            ]
//        )
//    ))
    DefiDetailView(position: .lending(
        LendingPosition(
            protocolName: "HyperLend",
            chain: .hype,
            image: "dust",
            url: "https://app.neverland.money/",
            supplied: [
                TokenAmount(symbol: "HYPE", amount: 1200, priceUSD: 0.12)
            ],
            borrowed: [
                TokenAmount(symbol: "USDC", amount: 80, priceUSD: 1)
            ],
            supplyAPY: 12.5,
            borrowAPY: 9.3,
            healthRate: 1.08,
            liquidationThreshold: 0.75
        )
    ))
}
