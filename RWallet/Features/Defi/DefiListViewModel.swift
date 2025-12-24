//
//  DefiListViewModel.swift
//  RWallet
//
//  Created by Rendi  on 24/12/25.
//

import Foundation

final class DefiListViewModel: ObservableObject {
    
    // MARK: - DeFi Positions List
    @Published var positions: [DeFiPosition] = [

        // MARK: - Locked (6)

        .locked(
            LockedTokenPosition(
                protocolName: "KittenSwap",
                chain: .hype,
                image: "kitten",
                url: "https://kittenswap.finance",
                lockId: "veKITTEN#15202",
                lockedToken: TokenAmount(symbol: "KITTEN", amount: 310_047.13, priceUSD: 0.0012),
                unlockTime: Calendar.current.date(from: DateComponents(year: 2027, month: 11, day: 11))!,
                rewards: [
                    LockedRewardPool(
                        pair: "WHYPE + USDT",
                        tokens: [
                            TokenAmount(symbol: "HYPE", amount: 0.79, priceUSD: 58),
                            TokenAmount(symbol: "USDT", amount: 22.4, priceUSD: 1)
                        ]
                    )
                ]
            )
        ),

        .locked(
            LockedTokenPosition(
                protocolName: "Curve",
                chain: .eth,
                image: "curve",
                url: "https://curve.fi",
                lockId: "veCRV#8821",
                lockedToken: TokenAmount(symbol: "CRV", amount: 12_500, priceUSD: 0.52),
                unlockTime: Calendar.current.date(from: DateComponents(year: 2026, month: 6, day: 1))!,
                rewards: []
            )
        ),

        .locked(
            LockedTokenPosition(
                protocolName: "Convex",
                chain: .eth,
                image: "convex",
                url: "https://convexfinance.com",
                lockId: "cvxLock#1920",
                lockedToken: TokenAmount(symbol: "CVX", amount: 3_200, priceUSD: 2.9),
                unlockTime: Calendar.current.date(from: DateComponents(year: 2028, month: 2, day: 10))!,
                rewards: []
            )
        ),

        .locked(
            LockedTokenPosition(
                protocolName: "Stargate",
                chain: .arb,
                image: "arb",
                url: "https://stargate.finance",
                lockId: "veSTG#441",
                lockedToken: TokenAmount(symbol: "STG", amount: 18_000, priceUSD: 0.44),
                unlockTime: Calendar.current.date(from: DateComponents(year: 2026, month: 12, day: 31))!,
                rewards: []
            )
        ),

        .locked(
            LockedTokenPosition(
                protocolName: "GMX",
                chain: .arb,
                image: "gmx",
                url: "https://gmx.io",
                lockId: "esGMX#777",
                lockedToken: TokenAmount(symbol: "esGMX", amount: 52, priceUSD: 42),
                unlockTime: Calendar.current.date(from: DateComponents(year: 2026, month: 9, day: 18))!,
                rewards: []
            )
        ),

        .locked(
            LockedTokenPosition(
                protocolName: "Balancer",
                chain: .eth,
                image: "balancer",
                url: "https://balancer.fi",
                lockId: "veBAL#301",
                lockedToken: TokenAmount(symbol: "BAL", amount: 2_400, priceUSD: 3.1),
                unlockTime: Calendar.current.date(from: DateComponents(year: 2027, month: 3, day: 5))!,
                rewards: []
            )
        ),

        // MARK: - Lending (7)

        .lending(
            LendingPosition(
                protocolName: "Aave V3",
                chain: .arb,
                image: "aave",
                url: "https://aave.com",
                supplied: [
                    TokenAmount(symbol: "ETH", amount: 2, priceUSD: 1800),
                    TokenAmount(symbol: "USDC", amount: 1500, priceUSD: 1)
                ],
                borrowed: [
                    TokenAmount(symbol: "USDT", amount: 900, priceUSD: 1)
                ],
                supplyAPY: 3.2,
                borrowAPY: 5.8,
                healthRate: 1.34,
                liquidationThreshold: 0.8
            )
        ),

        .lending(
            LendingPosition(
                protocolName: "Compound",
                chain: .eth,
                image: "compound",
                url: "https://compound.finance",
                supplied: [
                    TokenAmount(symbol: "ETH", amount: 1.1, priceUSD: 1800)
                ],
                borrowed: [],
                supplyAPY: 2.4,
                borrowAPY: 0,
                healthRate: 999,
                liquidationThreshold: 0.85
            )
        ),

        .lending(
            LendingPosition(
                protocolName: "Venus",
                chain: .bsc,
                image: "venus",
                url: "https://venus.io",
                supplied: [
                    TokenAmount(symbol: "BNB", amount: 12, priceUSD: 240)
                ],
                borrowed: [
                    TokenAmount(symbol: "USDT", amount: 800, priceUSD: 1)
                ],
                supplyAPY: 6.9,
                borrowAPY: 8.4,
                healthRate: 1.21,
                liquidationThreshold: 0.75
            )
        ),

        .lending(
            LendingPosition(
                protocolName: "HyperLend",
                chain: .hype,
                image: "hyperland",
                url: "https://hyperlend.finance",
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
        ),

        .lending(
            LendingPosition(
                protocolName: "Morpho",
                chain: .eth,
                image: "morpho",
                url: "https://morpho.xyz",
                supplied: [
                    TokenAmount(symbol: "USDC", amount: 8_000, priceUSD: 1)
                ],
                borrowed: [],
                supplyAPY: 5.1,
                borrowAPY: 0,
                healthRate: 999,
                liquidationThreshold: 0.9
            )
        ),

        // MARK: - Liquidity Pool (7)

        .liquidityPool(
            LiquidityPoolPosition(
                protocolName: "Aerodrome",
                chain: .arb,
                image: "aero",
                url: "https://aerodrome.finance",
                pair: "ETH / USDC",
                tokens: [
                    TokenAmount(symbol: "ETH", amount: 1.2, priceUSD: 1800),
                    TokenAmount(symbol: "USDC", amount: 2100, priceUSD: 1)
                ],
                poolShare: 0.015,
                apr: 24.6,
                impermanentLossUSD: -120,
                rewards: [
                    TokenAmount(symbol: "AERO", amount: 85, priceUSD: 0.78)
                ]
            )
        ),

        .liquidityPool(
            LiquidityPoolPosition(
                protocolName: "Uniswap V3",
                chain: .eth,
                image: "uniswap",
                url: "https://uniswap.org",
                pair: "ETH / USDT",
                tokens: [
                    TokenAmount(symbol: "ETH", amount: 0.8, priceUSD: 1800),
                    TokenAmount(symbol: "USDT", amount: 1400, priceUSD: 1)
                ],
                poolShare: 0.004,
                apr: 14.2,
                impermanentLossUSD: -45,
                rewards: []
            )
        ),

        .liquidityPool(
            LiquidityPoolPosition(
                protocolName: "PancakeSwap",
                chain: .bsc,
                image: "pancake",
                url: "https://pancakeswap.finance",
                pair: "BNB / USDT",
                tokens: [
                    TokenAmount(symbol: "BNB", amount: 4.5, priceUSD: 240),
                    TokenAmount(symbol: "USDT", amount: 1100, priceUSD: 1)
                ],
                poolShare: 0.008,
                apr: 18.2,
                impermanentLossUSD: -65,
                rewards: [
                    TokenAmount(symbol: "CAKE", amount: 42, priceUSD: 2.1)
                ]
            )
        ),

        .liquidityPool(
            LiquidityPoolPosition(
                protocolName: "SushiSwap",
                chain: .arb,
                image: "sushi",
                url: "https://sushi.com",
                pair: "ARB / ETH",
                tokens: [
                    TokenAmount(symbol: "ARB", amount: 1200, priceUSD: 1.05),
                    TokenAmount(symbol: "ETH", amount: 0.45, priceUSD: 1800)
                ],
                poolShare: 0.006,
                apr: 21.9,
                impermanentLossUSD: -88,
                rewards: [
                    TokenAmount(symbol: "SUSHI", amount: 120, priceUSD: 1.3)
                ]
            )
        )
    ]

    
    // MARK: - Selected Position
    
    @Published var selectedPosition: DeFiPosition?
    
    // MARK: - Init
    
    init() {
        selectFirstPosition()
    }
    
    // MARK: - Helpers
    
    func selectFirstPosition() {
        if selectedPosition == nil {
            selectedPosition = positions.first
        }
    }
}

