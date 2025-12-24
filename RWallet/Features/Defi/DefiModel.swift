//
//  DefiModel.swift
//  RWallet
//
//  Created by Rendi  on 24/12/25.
//

import Foundation

// MARK: - Enums

enum DeFiCategory: String, Codable {
    case lending
    case liquidityPool
    case locked
    case staking
    case farming
}

enum Chain: String, Codable {
    case eth
    case arb
    case bsc
    case hype
    case mon
}

enum PositionStatus: String, Codable {
    case healthy
    case warning
    case liquidatable
}

// MARK: - Token Amount

struct TokenAmount: Codable, Identifiable {
    let id = UUID()
    let symbol: String
    let amount: Double
    let priceUSD: Double
    
    var valueUSD: Double {
        amount * priceUSD
    }
}

// MARK: - Lending / Borrowing

struct LendingPosition: Codable, Identifiable {
    let id = UUID()
    let protocolName: String
    let chain: Chain
    let image: String
    let url: String
    
    let supplied: [TokenAmount]
    let borrowed: [TokenAmount]
    
    let supplyAPY: Double
    let borrowAPY: Double
    
    /// contoh: 1.45 (semakin kecil semakin berisiko)
    let healthRate: Double
    let liquidationThreshold: Double
    
    var totalSuppliedUSD: Double {
        supplied.reduce(0) { $0 + $1.valueUSD }
    }
    
    var totalBorrowedUSD: Double {
        borrowed.reduce(0) { $0 + $1.valueUSD }
    }
    
    var status: PositionStatus {
        switch healthRate {
        case ..<1.1:
            return .liquidatable
        case 1.1..<1.3:
            return .warning
        default:
            return .healthy
        }
    }
}

// MARK: - Liquidity Pool

struct LiquidityPoolPosition: Codable, Identifiable {
    let id = UUID()
    
    let protocolName: String
    let chain: Chain
    let image: String
    let url: String
    
    let pair: String
    let tokens: [TokenAmount]
    
    let poolShare: Double
    let apr: Double
    
    let impermanentLossUSD: Double
    let rewards: [TokenAmount]
    
    var totalValueUSD: Double {
        tokens.reduce(0) { $0 + $1.valueUSD }
    }
}

// MARK: - Locked / veToken

struct LockedTokenPosition: Codable, Identifiable {
    let id = UUID()
    
    let protocolName: String
    let chain: Chain
    let image: String
    let url: String
    
    /// contoh: veKITTEN#15202
    let lockId: String
    
    let lockedToken: TokenAmount
    let unlockTime: Date
    
    /// rewards bisa berasal dari banyak pool
    let rewards: [LockedRewardPool]
    
    var totalValueUSD: Double {
        lockedToken.valueUSD + rewards.reduce(0) { $0 + $1.totalValueUSD }
    }
}

// MARK: - Locked Reward Pool

struct LockedRewardPool: Codable, Identifiable {
    let id = UUID()
    
    /// contoh: WHYPE + UBTC
    let pair: String
    let tokens: [TokenAmount]
    
    var totalValueUSD: Double {
        tokens.reduce(0) { $0 + $1.valueUSD }
    }
}

// MARK: - Unified DeFi Position (For UI)

enum DeFiPosition: Identifiable {
    case lending(LendingPosition)
    case liquidityPool(LiquidityPoolPosition)
    case locked(LockedTokenPosition)
    
    var id: UUID {
        switch self {
        case .lending(let p): return p.id
        case .liquidityPool(let p): return p.id
        case .locked(let p): return p.id
        }
    }
    
    var chain: Chain {
        switch self {
        case .lending(let p): return p.chain
        case .liquidityPool(let p): return p.chain
        case .locked(let p): return p.chain
        }
    }
    
    var category: DeFiCategory {
        switch self {
        case .lending: return .lending
        case .liquidityPool: return .liquidityPool
        case .locked: return .locked
        }
    }
}
