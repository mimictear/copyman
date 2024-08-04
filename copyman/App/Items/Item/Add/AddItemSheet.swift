import Core
import SwiftUI
import AnticsUI

public struct AddItemSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @FocusState private var isTitleInputFocused: Bool
    @FocusState private var isContentInputFocused: Bool
    
    @State private var viewModel = AddItemViewModel()
    
    public var body: some View {
        ClosableSheet {
            Text("Add item")
                .applyTextStyle(model: FontStyleModel(font: .title2, fontWeight: .bold))
        } content: {
            ScrollViewReader { scrollViewProxy in
                VStack(spacing: inputFormItemSpacing) {
                    ScrollView {
                        ValidatableRoundedBorderTextField(
                            label: "Title",
                            placeholder: "Enter title",
                            errorText: "Title cannot be empty",
                            applyValidation: viewModel.applyValidation,
                            text: $viewModel.title,
                            validationCondition: {
                                viewModel.hasAppropriateTitle
                            }
                        )
                        .focused($isTitleInputFocused)
                        .lineLimit(inputTextLimit)
                        .id(titleInputScrollIdentifier)
                        .focusing(id: titleInputScrollIdentifier, scrollViewProxy: scrollViewProxy)
                        .withTopMediumPadding()
                        
                        // TODO: if `is link?` checked -> validate url
                        // TODO: parse a content with type `url` as a link
                        ValidatableRoundedBorderTextField(
                            label: "Content",
                            placeholder: "Enter content",
                            keyboardType: viewModel.keyboardType,
                            errorText: "Content cannot be empty",
                            applyValidation: viewModel.applyValidation,
                            text: $viewModel.content,
                            validationCondition: {
                                viewModel.hasAppropriateContent
                            }
                        )
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .lineLimit(inputTextLimit)
                        .padding(.top, Padding.extremelySmall)
                        .id(contentInputScrollIdentifier)
                        .focused($isContentInputFocused)
                        .focusing(id: contentInputScrollIdentifier, scrollViewProxy: scrollViewProxy)
                        
                        HStack {
                            switchKeyboardTypeButton
                        }
                        .frame(height: keyboardTypeSwitchingBottonHeight)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        
                        Toggle(isOn: $viewModel.isSecured) {
                            Text("Secured")
                                .applyTextStyle(model: FontStyleModel(font: .subheadline))
                        }
                        .toggleStyle(.checkboxToggle)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Toggle(isOn: $viewModel.isLink) {
                            Text("Link")
                                .applyTextStyle(model: FontStyleModel(font: .subheadline))
                        }
                        .toggleStyle(.checkboxToggle)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        CapsuleButton(
                            background: .blue,
                            action: {
                                viewModel.applyValidation = true
                                if viewModel.canAddItem {
                                    addItem()
                                    dismiss()
                                }
                            },
                            label: {
                                Text("Add item")
                                    .applyTextStyle(
                                        model: FontStyleModel(
                                            fontWeight: .semibold,
                                            textColor: .white
                                        )
                                    )
                                    .frame(maxWidth: .infinity)
                            }
                        )
                        .withTopMediumPadding()
                    }
                }
            }
            .padding(.horizontal, Padding.medium)
            .onAppear(perform: { isTitleInputFocused = true })
        }
    }
    
    @MainActor
    private var switchKeyboardTypeButton: some View {
        Image(systemName: viewModel.keyboardTypeIcon)
            .symbolRenderingMode(.hierarchical)
            .foregroundStyle(.blue)
            .symbolEffect(.bounce, value: viewModel.keyboardType)
            .contentTransition(.symbolEffect(.replace))
            .font(keyboardTypeSwitchingIconSize)
            .onTapGesture {
                HapticManager.shared.fireHaptic(.buttonPress)
                isContentInputFocused = false
                /// It is unfortunate, but currently, the only way to change the keyboard type dynamically is to reset the focus state.
                Task.delayed(byTimeInterval: keyboardTypeSwitchingDelay) {
                    viewModel.switchKeyboardType { isContentInputFocused = true }
                }
            }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(
                title: viewModel.title,
                content: viewModel.content,
                secured: viewModel.isSecured,
                isURL: viewModel.isLink,
                timestamp: .now
            )
            modelContext.insert(newItem)
        }
    }
}

private let tagInputCharacterLimit = 3
private let inputFormItemSpacing: CGFloat = 20
private let inputTextLimit = 1

private let titleInputScrollIdentifier = 0
private let contentInputScrollIdentifier = 1

private let keyboardTypeSwitchingDelay: TimeInterval = 0.15
private let keyboardTypeSwitchingIconSize: Font = .system(size: 24)
private let keyboardTypeSwitchingBottonHeight: CGFloat = 24
