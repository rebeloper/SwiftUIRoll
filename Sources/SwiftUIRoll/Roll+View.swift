//
//  Roll+View.swift
//  SwiftUIRollBuild
//
//  Created by Alex Nagy on 27.03.2024.
//

import SwiftUI

public extension View {
    func onDelete(title: String? = nil, _ action: @escaping () -> Void) -> some View {
        self.swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive) {
                withAnimation {
                    action()
                }
            } label: {
                if let title {
                    Text(title)
                } else {
                    Image(systemName: "trash")
                }
            }
        }
    }
}
