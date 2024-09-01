import Core
import SwiftUI
import AnticsUI

struct ItemView: View {
    @Environment(\.openURL) private var openURL
    @Environment(\.modelContext) private var modelContext
    @Environment(Theme.self) private var theme
    @Environment(RouterPath.self) private var routerPath
    
    @State private var viewModel = ItemViewModel()
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

//                  HapticManager.shared.fireHaptic(.buttonPress)

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
                    if let content = item.content {
                        viewModel.dispatch(event: .copy(content: content))
                    }
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
            }
            .withTopMediumPadding()
        }
        .alignmentGuide(.listRowSeparatorLeading) { viewDimensions in
            -100
        }
        .sheet(isPresented: $viewModel.showDeleteConfirmation) {
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
                viewModel.showDeleteConfirmation = false
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
        .onChange(of: viewModel.event) { _, event in
            switch event {
            case .edit:
                routerPath.presentedSheet = .edit
            case let .pinOrUnpin(item):
                HapticManager.shared.fireHaptic(.buttonPress)
                item.pinned.toggle()
            case .copy:
                HapticManager.shared.fireHaptic(.buttonPress)
                copied.toggle()
            default: break
            }
            viewModel.dispatch(event: .idle)
        }
        .animation(.easeInOut, value: revealSensitiveContent)
        .contextMenu {
            contextMenu
                .environment(viewModel)
        }
        .swipeActions(edge: .trailing) {
            ItemRowSwipeView(mode: .trailing(action: .delete))
                .environment(viewModel)
        }
        //.sensoryFeedback(.decrease, trigger: <#T##Equatable#>)
        .listRowBackground(theme.primaryBackgroundColor)
        .listRowInsets(.init(horizontal: Padding.medium, vertical: Padding.small))
    }
    
    @MainActor
    private var revealSensitiveContentButton: some View {
        Button {
            HapticManager.shared.fireHaptic(.buttonPress)
            revealSensitiveContent.toggle()
        } label: {
            Image(systemName: revealSensitiveContent ? "eye.slash" : "eye")
                .symbolRenderingMode(.hierarchical)
                .foregroundStyle(.blue)
                .contentShape(Rectangle())
                .font(.body)
                .dynamicTypeSize(.large)
                .symbolEffect(.bounce, value: revealSensitiveContent)
        }
        .buttonStyle(.borderless)
        .tappablePadding(.init(side: Padding.small)) {
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
