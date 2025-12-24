//
//  TransactionView.swift
//  RWallet
//
//  Created by Rendi  on 24/12/25.
//

import SwiftUI

struct TransactionView: View {

    @Environment(\.horizontalSizeClass) private var sizeClass

    var body: some View {
        VStack {
            if sizeClass == .compact {
                // 📱 iOS → versi card
                TransactionsListView(transactions: TransactionModel.mock)
            } else {
                // 📲 iPad → versi table full-width
                TransactionsPadView(transactions: TransactionModel.mock)
            }
        }
    }
}


struct TransactionsListView: View {
    let transactions: [TransactionModel]

    var body: some View {
        List {
            ForEach(transactions.groupedByDate, id: \.0) { section in
                Section(section.0) {
                    ForEach(section.1) { tx in
                        TransactionRow(tx: tx)
                    }
                }
            }
        }
    }
}

struct TransactionRow: View {
    let tx: TransactionModel

    var icon: some View {
        Circle()
            .fill(Color.green.opacity(0.15))
            .frame(width: 44, height: 44)
            .overlay(
                Image(systemName: iconName)
                    .foregroundStyle(.green)
            )
    }

    var body: some View {
        HStack(spacing: 12) {
            icon
            VStack(alignment: .leading, spacing: 6) {

                // Action
                Text(tx.action.rawValue.capitalized)
                    .font(.headline)

                // Project
                Text(tx.project)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                // Details (optional)
//                ForEach(tx.details.prefix(2)) { detail in
//                    HStack(spacing: 4) {
//                        Image(systemName: detail.icon)
//                        Text(detail.text)
//                    }
//                    .font(.caption)
//                    .foregroundStyle(detail.color)
//                }
            }
            Spacer()
            // Gas fee
            VStack(alignment: .trailing, spacing: 4) {
                Text("Gas")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text(tx.gasFee)
                    .font(.footnote)
            }
        }
    }

    private var iconName: String {
        switch tx.action {
        case .vote: return "checkmark"
        case .execute: return "bolt.fill"
        case .approve: return "checkmark.seal.fill"
        case .multicall: return "square.stack.3d.up.fill"
        }
    }
}


struct TransactionRowPad: View {

    let tx: TransactionModel

    private var dateFormatter: DateFormatter {
        let f = DateFormatter()
        f.dateFormat = "yyyy/MM/dd HH:mm"
        return f
    }

    var body: some View {
        HStack(alignment: .top, spacing: 20) {

            // LEFT
            VStack(alignment: .leading, spacing: 6) {
                Text(dateFormatter.string(from: tx.date))
                    .font(.footnote)
                    .foregroundStyle(.secondary)

                Text(tx.hash)
                    .font(.footnote)
                    .foregroundStyle(.blue)
            }
            .frame(width: 170, alignment: .leading)

            // CENTER
            VStack(alignment: .leading, spacing: 8) {

                HStack(spacing: 8) {
                    Image(systemName: "bolt.fill")
                        .foregroundStyle(.primary)

                    Text(tx.action.rawValue)
                        .font(.headline)
                }

                Text(tx.project)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            VStack {
                ForEach(tx.details) { detail in
                    HStack(spacing: 6) {
                        Image(systemName: detail.icon)
                        Text(detail.text)
                    }
                    .font(.footnote)
                    .foregroundStyle(detail.color)
                }
            }

            Spacer()

            // RIGHT
            VStack(alignment: .trailing, spacing: 4) {
                Text("Gas fee")
                    .font(.footnote)
                    .foregroundStyle(.secondary)

                Text(tx.gasFee)
                    .font(.footnote)
            }
            .frame(width: 200, alignment: .trailing)
        }
        .padding(.vertical, 14)
        .padding(.horizontal)
        .background(
            Color(.systemBackground)
        )
        .overlay(
            Divider(),
            alignment: .bottom
        )
    }
}

struct TransactionsPadView: View {

    let transactions: [TransactionModel]

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(transactions) { tx in
                    TransactionRowPad(tx: tx)
                }
            }
        }
    }
}


#Preview {
    TransactionView()
}
