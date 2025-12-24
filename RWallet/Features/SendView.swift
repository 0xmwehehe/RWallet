//
//  SendView.swift
//  RWallet
//
//  Created by Rendi  on 24/12/25.
//

import SwiftUI

struct SendView: View {
    @Environment(\.horizontalSizeClass) private var sizeClass
    @State private var amount: String = ""
    @State private var selectedToken: TokenModel?
    @StateObject private var vm = TokenListViewModel()
    
    var body: some View {
        if (sizeClass == .regular) {
            SplitView {
                ScrollView {
                    LazyVStack {
                        ForEach(vm.tokens) { token in
                            TokenRowView(token: token)
                                .foregroundStyle(selectedToken == token ?
                                                 Color(uiColor: .systemBackground) :
                                                    Color(uiColor: .label))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .background(
                                    selectedToken == token ?
                                    Color.accentColor :
                                        Color(uiColor: .systemBackground)
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    if selectedToken == token {
                                        selectedToken = nil
                                    } else {
                                        selectedToken = token
                                    }
                                }
                        }
                    }
                    .padding()
                }
            } detail: {
                VStack(spacing: 20) {
                    Text(selectedToken?.name ?? "")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    // MARK: - From
                    AddressRow(
                        title: "From",
                        address: "0xf00674...89f2c4"
                    ) {
                        Circle()
                            .fill(Color.green)
                    } sheetContent: {
                        Text("Select From Wallet")
                            .font(.title)
                            .padding()
                            .presentationDetents([.medium])
                    }
                    AddressRow(
                        title: "To",
                        address: nil,
                        placeholder: "Choose wallet"
                    ) {
                        Image(systemName: "person.fill")
                            .foregroundColor(.gray)
                    } sheetContent: {
                        Text("Select From Wallet")
                            .font(.title)
                            .padding()
                            .presentationDetents([.medium])
                    }
                    
                    // MARK: - Amount Header
                    HStack {
                        Text("Amount")
                            .font(.headline)
                        
                        Spacer()
                        
                        Text("Balance: 0.00166129")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    // MARK: - Amount Card
                    HStack {
                        VStack(alignment: .leading) {
                            TextField("0", text: $amount)
                                .font(.largeTitle)
                                .keyboardType(.decimalPad)
                            
                            Text("$0")
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 12) {
                            Text("MAX")
                                .font(.subheadline)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(Color.blue.opacity(0.15))
                                .cornerRadius(8)
                        }
                        Spacer()
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(16)
                    
                    Spacer()
                    Button(action: {
                        print("Confirm tapped")
                    }) {
                        HStack {
                            Image(systemName: "faceid")
                            Text("Confirm")
                                .font(.headline)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.35))
                        .foregroundColor(.white)
                        .cornerRadius(16)
                    }
                }
                .padding()
            }
            
        } else {
            VStack {
                VStack(spacing: 20) {
                    
                    // MARK: - From
                    AddressRow(
                        title: "From",
                        address: "0xf00674...89f2c4"
                    ) {
                        Circle()
                            .fill(Color.green)
                    } sheetContent: {
                        Text("Select From Wallet")
                            .font(.title)
                            .padding()
                            .presentationDetents([.medium])
                    }
                    AddressRow(
                        title: "To",
                        address: nil,
                        placeholder: "Choose wallet"
                    ) {
                        Image(systemName: "person.fill")
                            .foregroundColor(.gray)
                    } sheetContent: {
                        Text("Select From Wallet")
                            .font(.title)
                            .padding()
                            .presentationDetents([.medium])
                    }
                    
                    // MARK: - Amount Header
                    HStack {
                        Text("Amount")
                            .font(.headline)
                        
                        Spacer()
                        
                        Text("Balance: 0.00166129")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    // MARK: - Amount Card
                    HStack {
                        VStack(alignment: .leading) {
                            TextField("0", text: $amount)
                                .font(.largeTitle)
                                .keyboardType(.decimalPad)
                            
                            Text("$0")
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 12) {
                            Text("MAX")
                                .font(.subheadline)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(Color.blue.opacity(0.15))
                                .cornerRadius(8)
                            
                            HStack {
                                Image(systemName: "diamond.fill")
                                Text("ETH")
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color(.systemGray5))
                            .cornerRadius(20)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(16)
                }
                
                Spacer()
                
                // MARK: - Confirm Button
                Button(action: {
                    print("Confirm tapped")
                }) {
                    HStack {
                        Image(systemName: "faceid")
                        Text("Confirm")
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue.opacity(0.35))
                    .foregroundColor(.white)
                    .cornerRadius(16)
                }
            }
            .padding()
        }
    }
}

#Preview {
    SendView()
}
