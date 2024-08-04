import Core
import SwiftUI
import AnticsUI

struct ItemView: View {
    @Environment(\.openURL) private var openURL
    @Environment(\.modelContext) private var modelContext
    @Environment(Theme.self) private var theme
    
    @State private var viewModel = ItemViewModel()
    @State private var showDeleteConfirmation = false
    @State private var revealSensitiveContent = false
    
    let item: Item
    @Binding var copied: Bool
    
    // TODO: Create a coordinator to manage all context menu actions
    var body: some View {
        VStack(spacing: .zero) {
            VStack(alignment: .leading, spacing: .zero) {
                HStack {
                    Text(item.title!)
                        .applyTextStyle(model: FontStyleModel(font: .title3, fontWeight: .semibold))
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if item.pinned {
                        Image(systemName: "pin")
                            .font(.caption)
                    }
                    
//                    Button {
//                        HapticManager.shared.fireHaptic(.buttonPress)
//                        item.pinned.toggle()
//                    } label: {
//                        Image(systemName: item.pinned ? "pin.slash" : "pin")
//                            .font(.caption)
//                    }
                }
                .padding(.bottom, Padding.small)
                
                HStack {
                    Text(item.content!)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                        .privacySensitive()
                    
                    if item.secured { revealSensitiveContentButton }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: 4) {
                    if item.isURL {
                        Text("[link]")
                            .applyTextStyle(model: FontStyleModel(font: .footnote, textColor: .gray))
                    }
                    if item.secured {
                        Text("[secured]")
                            .applyTextStyle(model: FontStyleModel(font: .footnote, textColor: .gray))
                    }
                }
                .padding(.top, Padding.small)
                
                Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    .applyTextStyle(model: FontStyleModel(font: .footnote, textColor: .gray))
                    .padding(.top, Padding.small)
            }
            .redacted(reason: revealSensitiveContent ? .invalidated : .privacy)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // TODO: When type = [link] open it in browser (tap on the card itself)
            // TODO: for other types just copy by tapping on the card
            HStack(spacing: 24) {
                Spacer()
                Button {
                    viewModel.copyTextToClipboard(item.content!)
                    HapticManager.shared.fireHaptic(.buttonPress)
                    copied.toggle()
                } label: {
                    Image(systemName: "doc.on.doc")
                        .contentShape(Rectangle())
                        .font(.body)
                        .dynamicTypeSize(.large)
                }
                .buttonStyle(.borderless)
                
                ShareLink(item: item.content!) {
                    Image(systemName: "square.and.arrow.up")
                        //.foregroundColor(Color(UIColor.secondaryLabel))
                        .contentShape(Rectangle())
                        .font(.body)
                        .dynamicTypeSize(.large)
                }
                .buttonStyle(.borderless)
                
                Menu {
                    Button("Delete", role: .destructive) {
                        showDeleteConfirmation.toggle()
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
            .withTopMediumPadding()
        }
        .alignmentGuide(.listRowSeparatorLeading) { viewDimensions in
            -100
        }
        .sheet(isPresented: $showDeleteConfirmation) {
            ItemDeletionConfirmationView(item: item) {
                Task {
                    withAnimation {
                        modelContext.delete(item)
                        do {
                            try modelContext.save()
                        } catch {
                            fatalError("Something went wrong")
                        }
                    }
                }
                showDeleteConfirmation = false
            }
        }
        .background {
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    if item.isURL, let urlString = item.content {
                        openURL(with: urlString)
                    }
                }
        }
        .onAppear {
            revealSensitiveContent = !item.secured
        }
        .animation(.easeInOut, value: revealSensitiveContent)
        .contextMenu {
            contextMenu
        }
        .swipeActions(edge: .trailing) {
            ItemRowSwipeView(mode: .trailing(action: .delete))
        }
        
        .listRowBackground(theme.primaryBackgroundColor)
        .listRowInsets(.init(horizontal: Padding.medium, vertical: Padding.small))
    }
    
    @MainActor
    private var revealSensitiveContentButton: some View {
        Image(systemName: revealSensitiveContent ? "eye.slash" : "eye")
            .symbolRenderingMode(.hierarchical)
            .foregroundStyle(.blue)
            .symbolEffect(.bounce, value: revealSensitiveContent)
            .onTapGesture {
                HapticManager.shared.fireHaptic(.buttonPress)
                revealSensitiveContent.toggle()
            }
    }
    
    private var contextMenu: some View {
        ItemRowContextMenu(item: item)
    }
    
    private func openURL(with urlString: String) {
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            openURL(url)
        }
    }
}
