//
//  ImageOverlayView.swift
//  RWallet
//
//  Created by Rendi  on 24/12/25.
//


import SwiftUI

struct ImageOverlayView: View {
    let mainImage: Image
    let overlayImage: Image
    
    let mainSize: CGFloat
    let overlaySize: CGFloat
    
    init(
        mainImage: Image,
        overlayImage: Image,
        mainSize: CGFloat = 36,
        overlaySize: CGFloat = 16
    ) {
        self.mainImage = mainImage
        self.overlayImage = overlayImage
        self.mainSize = mainSize
        self.overlaySize = overlaySize
    }
    
    var body: some View {
        mainImage
            .resizable()
            .scaledToFit()
            .frame(width: mainSize, height: mainSize)
            .clipShape(Circle())
            .overlay(
                overlayImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: overlaySize, height: overlaySize)
                    .clipShape(Circle())
                // ⬇️ geser keluar setengah ukuran overlay
                    .offset(
                        x: overlaySize / 4,
                        y: overlaySize / 4
                    ),
                alignment: .bottomTrailing
            )
    }
}