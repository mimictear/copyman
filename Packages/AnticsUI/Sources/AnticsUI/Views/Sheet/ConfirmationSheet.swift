import SwiftUI

public struct ConfirmationSheet<Header, Content> : View where Header : View, Content : View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    
    private let message: String?
    private let messageEdgeInsets: EdgeInsets
    private let negativeButtonTitle: String?
    private let positiveButtonTitle: String
    private let positiveButtonBackground: Color
    private let isPositiveButtonDisabled: Bool
    private let positiveButtonAction: () -> Void
    @ViewBuilder private let header: () -> Header
    @ViewBuilder private let content: () -> Content
    
    public var body: some View {
        VStack {
            HStack {
                header()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(squared: 16)
                }
                .frame(alignment: .trailing)
            }
            .frame(maxWidth: .infinity)
            .withHorizontalMediumPadding()
            .withTopMediumPadding()
            
            if let message {
                Text(message)
                    .applyTextStyle(model: FontStyleModel())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(messageEdgeInsets)
                    .padding(.top, Padding.extremelySmall)
            }
            
            content()
                .padding([.horizontal, .top], Padding.medium)
                .padding(.bottom, contentBottomPadding)
            
            HStack {
                if let negativeButtonTitle {
                    Button {
                        dismiss()
                    } label: {
                        Text(negativeButtonTitle)
                            .font(.callout)
                            .frame(maxWidth: .infinity)
                    }
                    .frame(height: 48)
                    .border(
                        color: .contentBackground,
                        cardCornerRadius: cardCornerRadius,
                        borderColor: Color.blue
                    )
                }
                
                CapsuleButton(
                    background: positiveButtonBackground,
                    disabled: isPositiveButtonDisabled,
                    action: {
                        positiveButtonAction()
                        dismiss()
                    },
                    label: {
                        Text(positiveButtonTitle)
                            .font(.callout)
                            .frame(maxWidth: .infinity)
                    }
                )
            }
            .padding(.horizontal, Padding.medium)
            .padding(.bottom, Padding.medium)
        }
    }
    
    public init(
        message: String? = nil,
        messageEdgeInsets: EdgeInsets = .init(horizontal: Padding.medium, vertical: 0),
        negativeButtonTitle: String? = nil,
        positiveButtonTitle: String,
        positiveButtonBackground: Color? = nil,
        isPositiveButtonDisabled: Bool = false,
        positiveButtonAction: @escaping () -> Void,
        @ViewBuilder header: @escaping () -> Header,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.message = message
        self.messageEdgeInsets = messageEdgeInsets
        self.negativeButtonTitle = negativeButtonTitle
        self.positiveButtonTitle = positiveButtonTitle
        self.positiveButtonBackground = positiveButtonBackground ?? Color.blue
        self.isPositiveButtonDisabled = isPositiveButtonDisabled
        self.positiveButtonAction = positiveButtonAction
        self.header = header
        self.content = content
    }
}

private let contentBottomPadding: CGFloat = 20
private let cardCornerRadius: CGFloat = 99

#Preview {
    ConfirmationSheet(
        negativeButtonTitle: "Cancel",
        positiveButtonTitle: "Delete",
        positiveButtonBackground: Color.blue,
        positiveButtonAction: {},
        header: {
            Text("Delete this item?")
                .font(.title2)
        },
        content: {
            VStack(alignment: .leading) {
                Text("Title")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("Text")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    )
    .preferredColorScheme(.light)
}
