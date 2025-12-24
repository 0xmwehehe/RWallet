//
//  SearchView.swift
//  RWallet
//
//  Created by Rendi  on 24/12/25.
//

import SwiftUI

struct SearchView: View {
    @Binding var searchText: String
    var placeholder: String = "Search..."
    var onSubmit: (() -> Void)? = nil
    
    @FocusState private var isTextFieldFocused: Bool
    @State private var textFieldID = UUID() // Untuk mencegah dismiss ketika tap di dalam
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField(placeholder, text: $searchText)
                .id(textFieldID)
                .textFieldStyle(.plain)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .focused($isTextFieldFocused)
                .submitLabel(.search)
                .onSubmit {
                    onSubmit?()
                    isTextFieldFocused = false
                }
                .onTapGesture {
                    // Mencegah dismiss ketika tap di dalam textfield
                    isTextFieldFocused = true
                }
            
            if !searchText.isEmpty || isTextFieldFocused {
                Button {
                    isTextFieldFocused = false
                    searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
                .buttonStyle(.plain)
                .transition(.move(edge: .trailing))
            }
            
        }
        .padding(12)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .padding(.horizontal)
        .animation(.default, value: isTextFieldFocused)
    }
}

// Penggunaan:

#Preview {
    SearchView(searchText: .constant(""))
}

struct DismissKeyboardOnTap: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                dismissKeyboard()
            }
    }
    
    private func dismissKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}

extension View {
    func dismissKeyboardOnTap() -> some View {
        self.modifier(DismissKeyboardOnTap())
    }
}
