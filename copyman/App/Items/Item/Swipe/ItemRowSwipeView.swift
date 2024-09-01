import Core
import SwiftUI
import AnticsUI

struct ItemRowSwipeView: View {
    @Environment(Theme.self) private var theme
    @Environment(ItemViewModel.self) private var viewModel
    
    enum Mode {
        case leading(action: ItemSwipeAction)
        case trailing(action: ItemSwipeAction)
    }
    
    let mode: Mode
    
    var body: some View {
        switch mode {
        case .leading:
            leadingSwipeActions
        case let .trailing(action):
            makeTrailingSwipeActions(action: action)
        }
    }
    
    @ViewBuilder
    private func makeTrailingSwipeActions(action: ItemSwipeAction) -> some View {
        makeSwipeButton(action: action)
            .tint(action.tintColor)
    }
    
    @ViewBuilder
    private var leadingSwipeActions: some View {
        EmptyView()
    }
    
    @ViewBuilder
    private func makeSwipeButton(action: ItemSwipeAction) -> some View {
        switch action {
        case .none:
          EmptyView()
        case .delete:
            makeSwipeButtonForTask(action: .delete) {
                viewModel.dispatch(event: .delete)
            }
        default:
            EmptyView()
        }
    }
    
    @ViewBuilder
    private func makeSwipeButtonForTask(
        action: ItemSwipeAction,
        task: @escaping () async -> Void
    ) -> some View {
        Button {
            Task.delayed(byTimeInterval: actionDelay) { @MainActor in
                HapticManager.shared.fireHaptic(.notification(.success))
                await task()
            }
        } label: {
            makeSwipeLabel(action: action)
        }
    }
    
    @ViewBuilder
    private func makeSwipeLabel(action: ItemSwipeAction) -> some View {
        Label("Delete", systemImage: "xmark.bin")
//        Label("Delete",
//              imageNamed: "xmark.bin")
//        .labelStyle(.iconOnly)
//        .environment(\.symbolVariants, .none)
    }
}

private let actionDelay: TimeInterval = 0.35
