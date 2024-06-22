import SwiftUI

struct ItemView: View {
    @State private var viewModel = ItemViewModel()
    
    let item: Item
    @Binding var copied: Bool
    
    var body: some View {
        // pin icon in the list
        // add tag
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
            
            Button {
                viewModel.copyTextToClipboard(item.content!)
                HapticManager.shared.fireHaptic(.buttonPress)
                copied.toggle()
            } label: {
                Image(systemName: "doc.on.doc")
            }
        }
        // edit button
    }
}
