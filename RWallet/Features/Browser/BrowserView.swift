//
//  BrowserView.swift
//  RWallet
//
//  Created by Rendi  on 24/12/25.
//

import SwiftUI

struct DAppModel: Identifiable {
    let id = UUID()
    let name: String
    let icon: String // asset / system image
    let url: String
}

struct BrowserView: View {

    @State private var urlText = ""
    @State private var currentURL: URL?
    @State private var showWeb = false
    let sampleDApps: [DAppModel] = [
        .init(name: "Uniswap", icon: "arrow.left.arrow.right", url: "https://app.uniswap.org"),
        .init(name: "Aave", icon: "banknote", url: "https://app.aave.com"),
        .init(name: "Pancake", icon: "flame", url: "https://pancakeswap.finance"),
        .init(name: "OpenSea", icon: "shippingbox", url: "https://opensea.io")
    ]


    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                // Quick DApps
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Popular DApps")
                            .font(.headline)
                        
                        DAppGridView(apps: sampleDApps) { app in
                            urlText = app.url
                            loadURL(app.url)
                        }
                    }
                    .padding()
                }

                Spacer()
                // Address Bar
                HStack {
                    Image(systemName: "globe")
                    
                    TextField("Search or enter URL", text: $urlText)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.URL)
                        .onSubmit {
                            loadURL(urlText)
                        }
                    
                    Button {
                        loadURL(urlText)
                    } label: {
                        Image(systemName: "arrow.right.circle.fill")
                    }
                }
                .padding(10)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .padding([.horizontal, .bottom])
            }
            .onTapGesture {
                hideKeyboard()
            }
//            .navigationTitle("Browser")
            .navigationDestination(isPresented: $showWeb) {
                if let url = currentURL {
                    DeFiWebView(url: url)
                        .ignoresSafeArea()
                }
            }
        }
    }

    private func loadURL(_ text: String) {
        var final = text
        if !final.hasPrefix("http") {
            final = "https://" + final
        }
        if let url = URL(string: final) {
            currentURL = url
            showWeb = true
        }
    }
}

#Preview {
    BrowserView()
}
