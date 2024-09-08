import Storage
import SwiftUI
import AnticsUI
import SwiftData

@MainActor
struct ItemsView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(Theme.self) private var theme
    
    @Query private var items: [ItemModel]
    
    @State private var routerPath = RouterPath()
    @State private var showingCopiedAlert = false
    @State private var searchText = ""
    
    var filteredItems: [ItemModel] {
        if searchText.isEmpty {
            return items
        } else {
            // TODO: Refactor; also add: `content` & `tag`
            return items.filter { item in
                guard let title = item.title  else {
                    return false
                }
                return title.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    // TODO: Tags: favorites, links
    // TODO: Add `pin view` to show all pins
    // TODO: Show tags view at the top (right below the toolbar)
    var body: some View {
        // TODO: Add Tag view
        NavigationSplitView {
            contentView
                .withSheetDestinations(sheetDestinations: $routerPath.presentedSheet)
                .searchable(text: $searchText, prompt: "Search items")
                .scrollIndicators(.hidden)
                .frame(maxHeight: .infinity)
                .toolbarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Copyman")
                            .applyTextStyle(
                                model: FontStyleModel(
                                    font: .title3,
                                    fontWeight: .bold,
                                    textColor: .primary
                                )
                            )
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            routerPath.presentedSheet = .settings
                        } label: {
                            Label("Settings", systemImage: "gearshape")
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            // TODO: Show filter options
                            routerPath.presentedSheet = .filter
                        } label: {
                            Label(
                                title: { Text("Filter Items") },
                                icon: { Image(systemName: "line.3.horizontal.decrease.circle") }
                            )
                            .labelStyle(.titleAndIcon)
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            routerPath.presentedSheet = .add
                        } label: {
                            Label(
                                title: { Text("Add Item") },
                                icon: { Image(systemName: "plus") }
                            )
                            .labelStyle(.titleAndIcon)
                        }
                    }
                }
                .withConfirmationAlert(
                    title: "Copied",
                    showing: $showingCopiedAlert
                )
                .safeAreaInset(edge: .top) {
                    headerView
                }
                .environment(routerPath)
        } detail: {
            Text("Select an item")
        }
    }
    
    private var headerView: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: .zero) {
                TagsView()
                    .padding(Padding.medium)
                
                PinsView()
                    .padding(Padding.medium)
            }
            Divider()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.contentBackground)
    }
    
    @ViewBuilder
    private var contentView: some View {
        if filteredItems.isEmpty {
            emptyView
        } else {
            itemsView
        }
    }
    
    private var itemsView: some View {
        ScrollViewReader { proxy in
            VStack(spacing: .zero) {
                List {
                    ForEach(filteredItems) { item in
                        ItemView(item: item, copied: $showingCopiedAlert)
                            .listSectionSeparator(.hidden, edges: .top)
                    }
                }
                .environment(\.defaultMinListRowHeight, 1)
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .background(theme.primaryBackgroundColor)
            }
        }
    }
    
    @ViewBuilder
    private var emptyView: some View {
        if searchText.isEmpty {
            ContentUnavailableView(label: {
                Label("No Items", systemImage: "tray.fill")
            }, description: {
                Text("New items you add will appear here.")
                    .padding(.top, Padding.small)
            }, actions: {
                Button {
                    routerPath.presentedSheet = .add
                } label: {
                    Text("Add new item")
                        .fontWeight(.semibold)
                        .padding(.horizontal, Padding.small)
                }
                .buttonStyle(.borderedProminent)
            })
        } else {
            ContentUnavailableView.search
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        // TODO: Ask for User Confirmation Before Proceeding
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ItemsView()
        .modelContainer(for: ItemModel.self, inMemory: true)
}
