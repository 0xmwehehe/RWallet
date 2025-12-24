//
//  TokenModel.swift
//  RWallet
//
//  Created by Rendi  on 24/12/25.
//

import Foundation

struct TokenModel: Identifiable, Hashable, Equatable {
    let id = UUID()
    let name: String
    let symbol: String
    let balance: Double
    let priceUSD: Double
    let change24h: Double
    let priceHistory: [PricePoint]
}

struct PricePoint: Identifiable, Equatable, Hashable {
    let id = UUID()
    let date: Date
    let price: Double
}

struct TransactionModel2: Identifiable {
    let id = UUID()
    let date: Date
    let type: String
    let amount: Double
    let usdValue: Double
}

struct PortfolioModel {
    var tokens: [TokenModel]
}
