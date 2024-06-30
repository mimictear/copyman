import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query private var items: [Item]
    
    @State private var showAddItemSheet = false
    @State private var showingCopiedAlert = false
    @State private var searchText = ""
    
    var filteredItems: [Item] {
        if searchText.isEmpty {
            return items
        } else {
            // TODO: Refactor; also add: `content` & `tag`
            return items.filter { item in
                if let title = item.title {
                    return title.contains(searchText)
                    
                } else {
                    return false
                }
            }
        }
    }
    
    // TODO: Add ContentUnavalableView for search results

    // TODO: Tags: favorites, links
    // TODO: Add `pin view` to show all pins
    // TODO: Show tags view at the top (right below the toolbar)
    var body: some View {
        // TODO: Add Tag view
        NavigationSplitView {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(filteredItems) { item in
                        ItemView(item: item, copied: $showingCopiedAlert)
                            .padding(.horizontal, Padding.small)
                            .padding(.bottom, Padding.small)
                    }
                    
                }
            }
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
                        // TODO: Open settings sheet
                    } label: {
                        Label("Settings", systemImage: "gearshape")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddItemSheet.toggle()
                    } label: {

                        Label(
                            title: { Text("Add Item") },
                            icon: { Image(systemName: "plus") }
                        )
                        .labelStyle(.titleAndIcon)
                    }
                }
            }
            .sheet(isPresented: $showAddItemSheet) {
                AddItemSheet()
            }
            .withConfirmationAlert(
                title: "Copied",
                showing: $showingCopiedAlert
            )
            .safeAreaInset(edge: .top) {
                ZStack(alignment: .bottom) {
                    Text("Tags")
                        .padding(Padding.medium)
                    
                    Divider()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.contentBackground)
            }
        } detail: {
            Text("Select an item")
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
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
