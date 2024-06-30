import SwiftUI

struct ItemView: View {
    @State private var viewModel = ItemViewModel()
    
    let item: Item
    @Binding var copied: Bool
    
    var body: some View {
        // pin/unpin icon in the list
        // add tag
        GroupBox {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text(item.title!)
                        .applyTextStyle(model: FontStyleModel(fontWeight: .semibold))
                        .lineLimit(1)
                    
                    Text(item.content!)
                        .privacySensitive()
                    
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
                .redacted(reason: item.secured ? .privacy : .invalidated)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // TODO: When type = [link] open it in browser (tap on the card itself)
                // TODO: for other types just copy by tapping on the card
                VStack(spacing: 0) {
                    Button {
                        // TODO: pin/unpin
                        HapticManager.shared.fireHaptic(.buttonPress)
                    } label: {
                        Image(systemName: "pin")
                    }
                    
                    Spacer()
                    
                    Button {
                        viewModel.copyTextToClipboard(item.content!)
                        HapticManager.shared.fireHaptic(.buttonPress)
                        copied.toggle()
                    } label: {
                        Image(systemName: "doc.on.doc")
                    }
                    
                    Spacer()
                    
                    ShareLink(item: item.content!) {
                        Image(systemName: "square.and.arrow.up")
                    }
                    
                    Spacer()
                    
                    Menu {
                        Button("Edit") {
                            print("Option 2 selected")
                        }
                        Button("Delete", role: .destructive) {
                            print("Option 3 selected")
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                    }
                }
            }
        }
    }
}
