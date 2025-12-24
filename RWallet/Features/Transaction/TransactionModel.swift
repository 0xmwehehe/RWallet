//
//  TransactionModel.swift
//  RWallet
//
//  Created by Rendi  on 24/12/25.
//

import SwiftUI

enum TxAction: String {
    case vote
    case execute
    case approve
    case multicall
}

struct TransactionModel: Identifiable {
    let id = UUID()

    let date: Date
    let hash: String

    let action: TxAction
    let project: String

    let details: [TxDetail]
    let gasFee: String
}

struct TxDetail: Identifiable {
    let id = UUID()
    let icon: String
    let text: String
    let color: Color
}


enum TransactionType {
    case interaction
    case sent
    case receive
}

private extension TransactionModel {

    static func tx(
        date: String,
        hash: String,
        action: TxAction,
        project: String,
        details: [TxDetail] = [],
        gas: String
    ) -> TransactionModel {

        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd HH:mm"

        return TransactionModel(
            date: f.date(from: date) ?? .now,
            hash: hash,
            action: action,
            project: project,
            details: details,
            gasFee: gas
        )
    }
}

private extension TxDetail {
    static func token(_ icon: String, _ text: String, _ color: Color) -> TxDetail {
        TxDetail(icon: icon, text: text, color: color)
    }
}


extension TransactionModel {
    
    static let mock: [TransactionModel] = [
        // MARK: - Dec 21
        .tx(
            date: "2025-12-21 17:07",
            hash: "0x6a11...7999",
            action: .vote,
            project: "KittenSwap",
            gas: "0.0001 HYPE ($0.0015)"
        ),
        
        // MARK: - Dec 14
        .tx(
            date: "2025-12-14 10:14",
            hash: "0xdf0d...cef5",
            action: .vote,
            project: "KittenSwap",
            gas: "0.0001 HYPE ($0.0018)"
        ),
        
        // MARK: - Dec 13
        .tx(
            date: "2025-12-13 07:40",
            hash: "0x802f...0103",
            action: .execute,
            project: "Project X",
            details: [
                .token("iphone.gen3", "+1 Uniswap - 0.3% - UBTC", .green),
                .token("bitcoinsign.circle.fill", "+<0.0001 UBTC", .green),
                .token("flame.fill", "+<0.0001 WHYPE", .green)
            ],
            gas: "0.0003 HYPE ($0.0081)"
        ),
        
            .tx(
                date: "2025-12-13 07:40",
                hash: "0x4413...2e3f",
                action: .approve,
                project: "Project X",
                gas: "<0.0001 HYPE ($0.0007)"
            ),
        
        // MARK: - Dec 09
        .tx(
            date: "2025-12-09 07:59",
            hash: "0x6d3d...0903",
            action: .multicall,
            project: "Project X",
            details: [
                .token("flame.fill", "+0.5833 HYPE", .green),
                .token("bitcoinsign.circle.fill", "+0.0002 UBTC", .green)
            ],
            gas: "<0.0001 HYPE ($0.0010)"
        ),
        
        // MARK: - Dec 05
        .tx(
            date: "2025-12-05 18:23",
            hash: "0x23e8...1a2d",
            action: .vote,
            project: "KittenSwap",
            gas: "<0.0001 HYPE ($0.0010)"
        ),
        
        // MARK: - Nov 29
        .tx(
            date: "2025-11-29 05:38",
            hash: "0xc5fb...f993",
            action: .vote,
            project: "KittenSwap",
            gas: "0.0001 HYPE ($0.0025)"
        ),
        
        // MARK: - Extra realism (13 more)
        .tx(
            date: "2025-11-28 21:12",
            hash: "0x8a21...a991",
            action: .execute,
            project: "Uniswap V3",
            details: [
                .token("bitcoinsign.circle.fill", "-0.0025 UBTC", .red),
                .token("flame.fill", "+1.45 HYPE", .green)
            ],
            gas: "0.0004 HYPE ($0.0092)"
        ),
        
            .tx(
                date: "2025-11-27 13:44",
                hash: "0x9912...ab32",
                action: .approve,
                project: "Aave",
                gas: "<0.0001 HYPE ($0.0006)"
            ),
        
            .tx(
                date: "2025-11-26 09:30",
                hash: "0x771a...dd90",
                action: .execute,
                project: "Curve",
                details: [
                    .token("flame.fill", "+0.234 HYPE", .green)
                ],
                gas: "0.0002 HYPE ($0.0045)"
            ),
        
            .tx(
                date: "2025-11-25 22:01",
                hash: "0x10aa...77ef",
                action: .multicall,
                project: "Project X",
                details: [
                    .token("bitcoinsign.circle.fill", "+0.0003 UBTC", .green)
                ],
                gas: "<0.0001 HYPE ($0.0009)"
            ),
        
            .tx(
                date: "2025-11-24 16:55",
                hash: "0x991f...a001",
                action: .vote,
                project: "KittenSwap",
                gas: "<0.0001 HYPE ($0.0011)"
            ),
        
            .tx(
                date: "2025-11-23 08:10",
                hash: "0xa992...bc01",
                action: .execute,
                project: "Balancer",
                details: [
                    .token("flame.fill", "+0.998 HYPE", .green)
                ],
                gas: "0.0003 HYPE ($0.0079)"
            ),
        
            .tx(
                date: "2025-11-22 19:47",
                hash: "0x129a...991a",
                action: .approve,
                project: "Uniswap",
                gas: "<0.0001 HYPE ($0.0005)"
            ),
        
            .tx(
                date: "2025-11-21 11:06",
                hash: "0x7719...009a",
                action: .vote,
                project: "KittenSwap",
                gas: "<0.0001 HYPE ($0.0010)"
            ),
        
            .tx(
                date: "2025-11-20 03:22",
                hash: "0x556a...bb21",
                action: .execute,
                project: "GMX",
                details: [
                    .token("bitcoinsign.circle.fill", "-0.0012 UBTC", .red)
                ],
                gas: "0.0002 HYPE ($0.0064)"
            ),
        
            .tx(
                date: "2025-11-19 14:39",
                hash: "0x2a90...8891",
                action: .multicall,
                project: "Project X",
                details: [
                    .token("flame.fill", "+0.12 HYPE", .green)
                ],
                gas: "<0.0001 HYPE ($0.0008)"
            ),
        
            .tx(
                date: "2025-11-18 07:58",
                hash: "0x888a...1211",
                action: .vote,
                project: "KittenSwap",
                gas: "<0.0001 HYPE ($0.0012)"
            ),
        
            .tx(
                date: "2025-11-17 20:33",
                hash: "0xabc1...9910",
                action: .approve,
                project: "Curve",
                gas: "<0.0001 HYPE ($0.0006)"
            ),
        
            .tx(
                date: "2025-11-16 09:11",
                hash: "0xff12...7789",
                action: .execute,
                project: "Uniswap",
                details: [
                    .token("bitcoinsign.circle.fill", "+0.0008 UBTC", .green)
                ],
                gas: "0.0003 HYPE ($0.0073)"
            )
    ]
}


extension Array where Element == TransactionModel {
    var groupedByDate: [(String, [TransactionModel])] {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium

        let grouped = Dictionary(grouping: self) {
            formatter.string(from: $0.date)
        }

        return grouped
            .sorted { $0.key > $1.key }
            .map { ($0.key, $0.value) }
    }
}
