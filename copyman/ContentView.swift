import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    @State private var showAddItemSheet = false
    @State private var showingCopiedAlert = false

    // TODO: Tags: favorites, links
    // TODO: Show tags view at the top (right below the toolbar)
    var body: some View {
        // TODO: Add Tag view
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    ItemView(item: item, copied: $showingCopiedAlert)
                        .listRowSeparator(.hidden)
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Copyman")
                        .applyTextStyle(
                            model: FontStyleModel(
                                font: .title3,
                                fontWeight: .bold,
                                textColor: .primary
                            )
                        )
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // TODO: Open settings sheet
                    } label: {
                        Label("Settings", systemImage: "gearshape")
                    }
                }
                
                ToolbarItem(placement: .bottomBar) {
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
                
//                ToolbarItem(placement: .bottomBar) {
//                    // TODO: Show as [icon - title]
//                    Button {
//                        showAddItemSheet.toggle()
//                    } label: {
//                        Label(
//                            title: { Text("Add Item") },
//                            icon: { Image(systemName: "plus") }
//                        )
//                        .labelStyle(.titleAndIcon)
//                    }
//                }
            }
            .sheet(isPresented: $showAddItemSheet) {
                AddItemSheet()
            }
            .withConfirmationAlert(
                title: "Copied",
                showing: $showingCopiedAlert
            )
            .safeAreaInset(edge: .top) {
                VStack {
                    Text("Tags")
                    
                    Divider()
                        .padding(.horizontal, -Padding.medium)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(Padding.medium)
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
