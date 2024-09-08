import Storage
import SwiftUI
import AnticsUI

struct ItemDeletionConfirmationView: View {
    let item: ItemModel
    let action: () -> Void
    
    var body: some View {
        ConfirmationSheet(
            negativeButtonTitle: "Cancel",
            positiveButtonTitle: "Delete",
            positiveButtonBackground: Color.red,
            positiveButtonAction: { action() },
            header: {
                Text("Delete \"\(item.title ?? "")\"")
                    .applyTextStyle(model: FontStyleModel(font: .title2, fontWeight: .semibold))
                    .lineLimit(1)
            },
            content: {
                VStack {
                    Text("Are you sure you want to delete this item? This item will be deleted immediately. You can't undo this action.")
                        .applyTextStyle(model: FontStyleModel())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                }
            }
        )
        .fitPresentationDetents()
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}
