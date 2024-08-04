import Core
import SwiftUI
import AnticsUI

@MainActor
struct ItemRowContextMenu: View {
    @Environment(\.displayScale) private var displayScale
    @Environment(\.openWindow) private var openWindow
    @Environment(RouterPath.self) private var routerPath
    
    let item: Item
    
    var body: some View {
        Button {
            Task {
                HapticManager.shared.fireHaptic(.buttonPress)
                item.pinned.toggle()
            }
        } label: {
            Label(item.pinned ? "Unpin" : "Pin",
                  systemImage: item.pinned ? "pin.slash" : "pin")
        }
        
        Button {
            Task {

            }
        } label: {
            Label("Share",
                  systemImage: "square.and.arrow.up")
        }
        
        Button {
            Task {

            }
        } label: {
            Label("Copy",
                  systemImage: "doc.on.doc")
        }
        
        Divider()
        
        Button {
            routerPath.presentedSheet = .edit
        } label: {
            Label("Edit",
                  systemImage: "pencil")
        }
        
        Section {
            Button(role: .destructive) {
                
            } label: {
                Label("Delete",
                      systemImage: "xmark.bin")
            }
        }
    }
}
