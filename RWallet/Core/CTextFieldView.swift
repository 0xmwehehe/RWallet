//
//  CTextFieldView.swift
//  RWallet
//
//  Created by Rendi  on 24/12/25.
//

import SwiftUI

struct AddressRow<LeadingIcon: View, SheetContent: View>: View {
    let title: String
    let address: String?
    let placeholder: String
    let leadingIcon: LeadingIcon
    let sheetContent: SheetContent

    @State private var showSheet = false

    init(
        title: String,
        address: String?,
        placeholder: String = "Select address",
        @ViewBuilder leadingIcon: () -> LeadingIcon,
        @ViewBuilder sheetContent: () -> SheetContent
    ) {
        self.title = title
        self.address = address
        self.placeholder = placeholder
        self.leadingIcon = leadingIcon()
        self.sheetContent = sheetContent()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)

            Button {
                showSheet.toggle()
            } label: {
                HStack {
                    leadingIcon
                        .frame(width: 36, height: 36)

                    Text(address ?? placeholder)
                        .font(.subheadline)
                        .foregroundColor(address == nil ? .secondary : .primary)

                    Spacer()

                    Image(systemName: "chevron.right")
                        .rotationEffect(.degrees(showSheet ? 90 : 0))
                        .foregroundColor(.gray)
                        .animation(.easeInOut(duration: 0.2), value: showSheet)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(14)
            }
            .buttonStyle(.plain)
        }
        .fontWeight(.bold)
        .sheet(isPresented: $showSheet) {
            sheetContent
        }
    }
}




#Preview {
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

}
