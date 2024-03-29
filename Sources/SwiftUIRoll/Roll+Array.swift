//
//  Roll+Array.swift
//  SwiftUIRollBuild
//
//  Created by Alex Nagy on 27.03.2024.
//

import SwiftUI

public extension Array where Element: Equatable {
    mutating func remove(_ element: Element) {
        guard let index = self.firstIndex(of: element) else { return }
        _ = withAnimation {
            self.remove(at: index)
        }
    }
}
