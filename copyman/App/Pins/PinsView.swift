import Storage
import SwiftUI
import AnticsUI
import SwiftData

struct PinsView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(RouterPath.self) private var routerPath
    
    @Query(filter: #Predicate<ItemModel> {
        $0.pinned
    })
    private var pinnedItems: [ItemModel]
    
    private var hasPinnedItems: Bool {
        !pinnedItems.isEmpty
    }
    
    // TODO: Add title `Pinned items`
    var body: some View {
        if pinnedItems.isEmpty {
            EmptyView()
        } else {
            HStack {
                totalPinnedCountView
                
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
    
    @ViewBuilder
    private var totalPinnedCountView: some View {
        if pinnedItems.count > 1 {
            //Text("(\(pinnedItems.count))")
            // TODO: if last -> chevron.down, else -> chevron.up
            Image(systemName: "chevron.down")
                .foregroundStyle(.blue)
        } else {
            EmptyView()
        }
    }
}
