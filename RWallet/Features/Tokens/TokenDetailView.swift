//
//  TokenDetailView.swift
//  RWallet
//
//  Created by Rendi  on 24/12/25.
//

import SwiftUI
import Charts

struct TokenDetailView: View {
    let token: TokenModel
    @State private var selectedTimeframe: Timeframe = .oneDay
    @State private var transactions: [TransactionModel] = TransactionModel.mock
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    enum Timeframe: String, CaseIterable {
        case oneDay = "1D"
        case oneWeek = "1W"
        case oneMonth = "1M"
        case oneYear = "1Y"
    }
    
    var filteredHistory: [PricePoint] {
        let now = Date()
        switch selectedTimeframe {
        case .oneDay:
            return token.priceHistory.filter { Calendar.current.isDate($0.date, inSameDayAs: now) }
        case .oneWeek:
            return token.priceHistory.filter { $0.date >= Calendar.current.date(byAdding: .day, value: -7, to: now)! }
        case .oneMonth:
            return token.priceHistory.filter { $0.date >= Calendar.current.date(byAdding: .month, value: -1, to: now)! }
        case .oneYear:
            return token.priceHistory.filter { $0.date >= Calendar.current.date(byAdding: .year, value: -1, to: now)! }
        }
    }
    
    var body: some View {
        Group {
            if horizontalSizeClass == .compact {
                // iPhone → List
                BaseDetailView{
                    listData
                }
                .navigationTitle(token.name)
            } else {
                listData
            }
        }
    }
    
    // MARK: Sections
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            if horizontalSizeClass != .compact {
                Text(token.name).font(.largeTitle).bold()
                Text(token.symbol).font(.title2).foregroundColor(.secondary)
            }
            
            Picker("Timeframe", selection: $selectedTimeframe) {
                ForEach(Timeframe.allCases, id: \.self) { timeframe in
                    Text(timeframe.rawValue).tag(timeframe)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Chart {
                ForEach(filteredHistory) { point in
                    LineMark(
                        x: .value("Date", point.date),
                        y: .value("Price", point.price)
                    )
                    .foregroundStyle(token.change24h >= 0 ? .green : .red)
                }
            }
            .frame(height: 200)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(Color(.secondarySystemBackground))
            )
        }
    }
    
    private var listData: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    headerSection
                    balanceRow
                    usdRow
                    infoRow
                    Divider()
                    transactionSection
                }
                .padding()
            }
            HStack {
                Button {
                    // transfer
                } label: {
                    HStack {
                        Image(systemName: "paperplane")
                        Text("Send")
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color.green)
                Button {
                    // Swap
                } label: {
                    HStack {
                        Image(systemName: "arrow.left.arrow.right")
                        Text("Swap")
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                Button {
                    // more
                } label: {
                    HStack {
                        Image(systemName: "ellipsis")
                            .frame(height: 18)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                }
                .buttonStyle(.bordered)
            }
            .padding([.horizontal])
        }
    }
    
    private var balanceRow: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("My Balance")
            HStack {
                Image(token.image)
                    .resizable()
                    .frame(width:24, height: 24)
                Text("\(token.balance, specifier: "%.2f") \(token.symbol)")
                    .font(.headline)
                Spacer()
                Text("\(token.balance * 100, specifier: "%.2f")")
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
    }
    
    private var infoRow: some View {
        VStack(spacing:15){
            HStack {
                Text("Token Name:").font(.headline)
                Spacer()
                Text("\(token.name)")
            }
            HStack {
                Text("Chain:").font(.headline)
                Spacer()
                Image(token.chain)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                Text("\(token.name)")
            }
            HStack {
                Text("Contract:").font(.headline)
                Spacer()
                HStack{
                    Text("0x9fdb...3463")
                    Image(systemName: "arrow.up.forward.app")
                    Image(systemName: "document.on.document")
                }
            }
            HStack {
                Text("FDV:").font(.headline)
                Spacer()
                Text("$ 1837.92B")
                    .fontWeight(.bold)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
    }
    
    private var usdRow: some View {
        HStack {
            Text("Issuer’s Website:").font(.headline)
            Spacer()
            Button {
                
            } label: {
                HStack{
                    Text("Momo.xyz")
                    Image(systemName: "arrow.up.forward.app")
                }
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
    }
    
    private var transactionSection: some View {
        LazyVStack(alignment: .leading, spacing: 0) {
            Text("History")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom)
            ForEach(transactions.groupedByDate, id: \.0) { section in
                Section(section.0) {
                    ForEach(section.1) { tx in
                        TransactionRow(tx: tx)
                            .padding(12)
                            .background(RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .fill(Color(.secondarySystemBackground)))
                            .padding(.vertical, 6)
                    }
                }
            }
        }
    }
}


#Preview {
    let history = (0..<30).map { i in
        PricePoint(date: Calendar.current.date(byAdding: .day, value: -i, to: Date())!, price: Double.random(in: 90...110))
    }
    let token = TokenModel(name: "Ethereum", symbol: "ETH", image: "eth", chain: "eth", balance: 2.5, priceUSD: 1800.0, change24h: 2.1, priceHistory: [])
    //    NavigationStack{
    TokenDetailView(token: token)
    //    }
    //    TokenListView()
}
