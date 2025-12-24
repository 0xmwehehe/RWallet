//
//  TokenListViewModel.swift
//  RWallet
//
//  Created by Rendi  on 24/12/25.
//

import Foundation

class TokenListViewModel: ObservableObject {
    @Published var tokens: [TokenModel] = [
        TokenModel(name: "Ethereum", symbol: "ETH", balance: 2.5, priceUSD: 1800.0, change24h: 2.1, priceHistory: []),
        TokenModel(name: "Bitcoin", symbol: "BTC", balance: 0.8, priceUSD: 30000.0, change24h: -1.2, priceHistory: []),
        TokenModel(name: "HypeToken", symbol: "HYPE", balance: 500, priceUSD: 0.12, change24h: 5.3, priceHistory: [])
    ]
    
    // Optional: bisa simpan selected token di ViewModel juga
    @Published var selectedToken: TokenModel?
    
    // Fungsi untuk select first token otomatis
    func selectFirstToken() {
        if selectedToken == nil {
            selectedToken = tokens.first
        }
    }
    
    // Fungsi untuk sorting tokens berdasarkan balance atau price
    func sortTokens(by key: SortKey) {
        switch key {
        case .balance:
            tokens.sort { $0.balance > $1.balance }
        case .price:
            tokens.sort { $0.priceUSD > $1.priceUSD }
        }
    }
    
    enum SortKey {
        case balance, price
    }
}
