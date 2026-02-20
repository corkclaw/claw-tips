//
//  SplitControlView.swift
//  ClawTips
//
//  Created by Engineer on 2026-02-19.
//

import SwiftUI

struct SplitControlView: View {
    @Binding var splitCount: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Split Between")
                .font(.headline)
                .foregroundStyle(.secondary)
            
            HStack {
                // Decrease Button
                Button {
                    if splitCount > 1 {
                        splitCount -= 1
                    }
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .font(.title)
                        .foregroundStyle(splitCount > 1 ? .accentColor : .gray)
                }
                .disabled(splitCount <= 1)
                
                Spacer()
                
                // Split Count Display
                VStack(spacing: 4) {
                    Text("\(splitCount)")
                        .font(.system(size: 48, weight: .bold))
                    
                    Text(splitCount == 1 ? "person" : "people")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                // Increase Button
                Button {
                    if splitCount < 20 {
                        splitCount += 1
                    }
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.title)
                        .foregroundStyle(splitCount < 20 ? .accentColor : .gray)
                }
                .disabled(splitCount >= 20)
            }
            .padding(.vertical, 8)
        }
    }
}

#Preview {
    SplitControlView(splitCount: .constant(4))
        .padding()
}
