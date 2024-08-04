import SwiftUI
import AnticsUI
import SwiftData

struct PinsView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(RouterPath.self) private var routerPath
    
    @Query(filter: #Predicate<Item> {
        $0.pinned
    })
    private var pinnedItems: [Item]
    
    private var hasPinnedItems: Bool {
        !pinnedItems.isEmpty
    }
    
    var body: some View {
        if pinnedItems.isEmpty {
            EmptyView()
        } else {
            HStack {
                Group {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(pinnedItems) { item in
                                Button {
                                    // TODO: Scroll to the appropriate item (and highlight them)
                                } label: {
                                    Text(item.title ?? "Empty")
                                }
                            }
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .animation(.easeInOut, value: hasPinnedItems)
                
                Button {
                    routerPath.presentedSheet = .pins
                } label: {
                    Image(systemName: "pin.square")
                        .contentShape(Rectangle())
                        .font(.title3)
                        .dynamicTypeSize(.large)
                }
                .buttonStyle(.borderless)
            }
        }
    }
}
