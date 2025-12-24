//
//  TokenListViewModel.swift
//  RWallet
//
//  Created by Rendi  on 24/12/25.
//

import Foundation

class TokenListViewModel: ObservableObject {
    @Published var tokens: [TokenModel] = [
        TokenModel(name: "Ethereum", symbol: "ETH", image: "weth", chain: "eth", balance: 2.5, priceUSD: 1800.0, change24h: 2.1, priceHistory: []),
        TokenModel(name: "Bitcoin", symbol: "BTC", image: "ubtc", chain: "hype", balance: 0.8, priceUSD: 30000.0, change24h: -1.2, priceHistory: []),
        TokenModel(name: "HypeToken", symbol: "HYPE", image: "hype", chain: "hype", balance: 500, priceUSD: 0.12, change24h: 5.3, priceHistory: []),
        TokenModel(
            name: "Ethereum",
            symbol: "ETH",
            image: "eth",
            chain: "eth",
            balance: 2.5,
            priceUSD: 1800.0,
            change24h: 2.1,
            priceHistory: []
        ),
        
        TokenModel(
            name: "Wrapped Bitcoin",
            symbol: "WBTC",
            image: "ubtc",
            chain: "eth",
            balance: 0.42,
            priceUSD: 30000.0,
            change24h: -0.8,
            priceHistory: []
        ),
        
        TokenModel(
            name: "Coinbase Wrapped BTC",
            symbol: "cbBTC",
            image: "cbbtc",
            chain: "arb",
            balance: 0.15,
            priceUSD: 30120.0,
            change24h: 1.4,
            priceHistory: []
        ),
        
        TokenModel(
            name: "Universal Bitcoin",
            symbol: "uBTC",
            image: "ubtc",
            chain: "hype",
            balance: 0.88,
            priceUSD: 29850.0,
            change24h: -1.2,
            priceHistory: []
        ),
        
        TokenModel(
            name: "USD Coin",
            symbol: "USDC",
            image: "usdc",
            chain: "eth",
            balance: 1200,
            priceUSD: 1.0,
            change24h: 0.0,
            priceHistory: []
        ),
        
        TokenModel(
            name: "USD Coin",
            symbol: "USDC",
            image: "usdc",
            chain: "arb",
            balance: 850,
            priceUSD: 1.0,
            change24h: 0.0,
            priceHistory: []
        ),
        
        TokenModel(
            name: "Tether USD",
            symbol: "USDT",
            image: "usdt",
            chain: "bsc",
            balance: 540,
            priceUSD: 1.0,
            change24h: 0.0,
            priceHistory: []
        ),
        
        TokenModel(
            name: "BNB",
            symbol: "BNB",
            image: "bsc",
            chain: "bsc",
            balance: 6.3,
            priceUSD: 240.0,
            change24h: 1.8,
            priceHistory: []
        ),
        
        TokenModel(
            name: "Aerodrome",
            symbol: "AERO",
            image: "aero",
            chain: "arb",
            balance: 1200,
            priceUSD: 0.78,
            change24h: 6.5,
            priceHistory: []
        ),
        
        TokenModel(
            name: "Pump",
            symbol: "PUMP",
            image: "pump",
            chain: "hype",
            balance: 25000,
            priceUSD: 0.004,
            change24h: 12.4,
            priceHistory: []
        ),
        
        TokenModel(
            name: "Monad",
            symbol: "MON",
            image: "mon",
            chain: "mon",
            balance: 900,
            priceUSD: 0.32,
            change24h: 9.8,
            priceHistory: []
        ),
        
        TokenModel(
            name: "Wrapped Ether",
            symbol: "WETH",
            image: "weth",
            chain: "arb",
            balance: 1.1,
            priceUSD: 1795.0,
            change24h: 2.0,
            priceHistory: []
        ),
        
        TokenModel(
            name: "Hyperliquid",
            symbol: "HYPE",
            image: "hype",
            chain: "hype",
            balance: 480,
            priceUSD: 0.12,
            change24h: 5.3,
            priceHistory: []
        ),
        
        TokenModel(
            name: "Arbitrum",
            symbol: "ARB",
            image: "arb",
            chain: "arb",
            balance: 320,
            priceUSD: 1.05,
            change24h: -2.4,
            priceHistory: []
        )
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
