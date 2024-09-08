import Core
import Storage
import SwiftUI
import AnticsUI

@MainActor
struct ItemRowContextMenu: View {
    @Environment(\.displayScale) private var displayScale
    @Environment(\.openWindow) private var openWindow
    @Environment(ItemViewModel.self) private var viewModel
    
    let item: ItemModel
    
    var body: some View {
        Button {
            viewModel.dispatch(event: .pinOrUnpin(item: item))
        } label: {
            Label(item.pinned ? "Unpin" : "Pin",
                  systemImage: item.pinned ? "pin.slash" : "pin")
        }
        
        Button {
            // TODO
        } label: {
            Label("Share", systemImage: "square.and.arrow.up")
        }
        
        Button {
            if let content = item.content {
                viewModel.dispatch(event: .copy(content: content))
            }
        } label: {
            Label("Copy", systemImage: "doc.on.doc")
        }
        
        Divider()
        
        Button {
            viewModel.dispatch(event: .edit(item: item))
        } label: {
            Label("Edit", systemImage: "pencil")
        }
        
        Section {
            Button(role: .destructive) {
                Task.delayed(byTimeInterval: actionDelay) { @MainActor in
                    viewModel.dispatch(event: .delete)
                }
            } label: {
                Label("Delete", systemImage: "xmark.bin")
            }
        }
    }
}

private let actionDelay: TimeInterval = 0.35
