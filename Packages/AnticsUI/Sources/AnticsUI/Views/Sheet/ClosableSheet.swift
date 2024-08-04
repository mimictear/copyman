import SwiftUI

public struct ClosableSheet<Title, Content> : View where Title : View, Content : View {
    @Environment(\.dismiss) private var dismiss
    @Environment(Theme.self) private var theme
    
    @ViewBuilder private let title: () -> Title
    @ViewBuilder private let content: () -> Content
    
    public var body: some View {
        NavigationStack {
            VStack {
                content()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .ignoresSafeArea(.keyboard, edges: .bottom)
            }
            .scrollIndicators(.hidden)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(theme.primaryBackgroundColor.opacity(0.30), for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    title()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(squared: closeButtonFrameSize)
                    }
                    .frame(alignment: .trailing)
                }
            }
        }
    }
    
    public init(
        @ViewBuilder title: @escaping () -> Title,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.content = content
    }
}

private let closeButtonFrameSize: CGFloat = 16
