//
//  IconGenerator.swift
//  Generate app icon using emoji
//
//  Usage: Open this in Xcode Playground or add to project, run in simulator,
//         and screenshot the view at 1024x1024
//

import SwiftUI

struct AppIconView: View {
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [Color.blue.opacity(0.8), Color.cyan],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            VStack(spacing: 8) {
                // Crab emoji
                Text("🦀")
                    .font(.system(size: 200))
                
                // Dollar signs in claws
                HStack(spacing: 40) {
                    Text("💵")
                        .font(.system(size: 80))
                        .rotationEffect(.degrees(-15))
                    
                    Text("💵")
                        .font(.system(size: 80))
                        .rotationEffect(.degrees(15))
                }
                .offset(y: -80)
            }
        }
        .frame(width: 1024, height: 1024)
    }
}

// For preview in Xcode
struct AppIconView_Previews: PreviewProvider {
    static var previews: some View {
        AppIconView()
    }
}
