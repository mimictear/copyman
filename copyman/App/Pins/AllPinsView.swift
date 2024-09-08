import Storage
import SwiftUI
import AnticsUI
import SwiftData

struct AllPinsView: View {
    @Environment(Theme.self) private var theme
    
    @State private var showingCopiedAlert = false
    
    @Query(filter: #Predicate<ItemModel> {
        $0.pinned
    })
    private var pinnedItems: [ItemModel]
    
    var body: some View {
        ClosableSheet {
            Text("Pinned Items")
                .applyTextStyle(model: FontStyleModel(font: .title2, fontWeight: .bold))
        } content: {
            VStack(spacing: .zero) {
                List {
                    ForEach(pinnedItems) { item in
                        ItemView(item: item, copied: $showingCopiedAlert)
                            .listSectionSeparator(.hidden, edges: .top)
                    }
                }
                .environment(\.defaultMinListRowHeight, 1)
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .background(theme.primaryBackgroundColor)
            }
            .withConfirmationAlert(
                title: "Copied",
                showing: $showingCopiedAlert
            )
        }
    }
    
    // TODO: empty view
}
