//
//  ApprovalView.swift
//  RWallet
//
//  Created by Rendi  on 24/12/25.
//

import SwiftUI

struct ApprovalView: View {

    enum Segment: String, CaseIterable, Identifiable {
        case contracts = "Contracts"
        case assets = "Assets"

        var id: String { rawValue }
    }

    @State private var selectedSegment: Segment = .contracts

    var body: some View {
        VStack(spacing: 16) {

            Picker("", selection: $selectedSegment) {
                ForEach(Segment.allCases) { segment in
                    Text(segment.rawValue)
                        .tag(segment)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)

            Group {
                switch selectedSegment {
                case .contracts:
                    contractsView
                case .assets:
                    assetsView
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationTitle("Approval")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Contracts
    private var contractsView: some View {
        List {
            VStack(alignment: .leading) {
                Text("Uniswap V3")
                    .font(.headline)
                Text("Unlimited approval")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            VStack(alignment: .leading) {
                Text("Aave")
                    .font(.headline)
                Text("Limited approval")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .listStyle(.plain)
    }

    // MARK: - Assets
    private var assetsView: some View {
        List {
            HStack {
                Text("ETH")
                Spacer()
                Text("Approved")
                    .foregroundColor(.green)
            }

            HStack {
                Text("USDC")
                Spacer()
                Text("Not approved")
                    .foregroundColor(.orange)
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    ApprovalView()
}
