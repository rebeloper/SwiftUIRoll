//
//  Roll.swift
//  SwiftUIRollBuild
//
//  Created by Alex Nagy on 27.03.2024.
//

import SwiftUI

public struct Roll<Data, Cell>: View where Data: RandomAccessCollection & MutableCollection, Data.Element: Identifiable & Hashable, Cell: View {
    
    @Binding private var data: Data
    @ViewBuilder private var cell: (Binding<Data.Element>) -> Cell
    @Binding private var selection: [Data.Element]
    
    public init(_ data: Binding<Data>, selection: Binding<[Data.Element]>? = nil, cell: @escaping (Binding<Data.Element>) -> Cell) {
        self._data = data
        self.cell = cell
        self.usesSelection = selection != nil
        self._selection = selection ?? .constant([])
    }
    
    @State private var usesSelection = false
    @State private var selectionIDs = Set<Data.Element.ID>()
    
    public var body: some View {
        Group {
            if usesSelection {
                List($data, selection: $selectionIDs) { $item in
                    cell($item)
                        .listRowBackground(Color.clear)
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .listRowSeparator(.hidden)
                }
                .onChange(of: selectionIDs) { oldValue, newValue in
                    selection.removeAll()
                    newValue.forEach { id in
                        data.forEach { element in
                            if element.id == id {
                                selection.append(element)
                            }
                        }
                    }
                }
            } else {
                List {
                    ForEach($data) { $item in
                        cell($item)
                    }
                    .onMove(perform: { indices, newOffset in
                        data.move(fromOffsets: indices, toOffset: newOffset)
                    })
                    .listRowBackground(Color.clear)
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .listRowSeparator(.hidden)
                }
            }
        }
        .listStyle(.plain)
    }
}
