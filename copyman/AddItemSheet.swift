import SwiftUI

public struct AddItemSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @FocusState private var isFocused: Bool
    
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
                        .focused($isFocused)
                        .lineLimit(inputTextLimit)
                        .id(titleInputScrollIdentifier)
                        .focusing(id: titleInputScrollIdentifier, scrollViewProxy: scrollViewProxy)
                        
                        // TODO: if `is link?` checked -> validate url
                        // TODO: parse a content with type `url` as a link
                        ValidatableRoundedBorderTextField(
                            label: "Content",
                            placeholder: "Enter content",
                            errorText: "Content cannot be empty",
                            applyValidation: viewModel.applyValidation,
                            text: $viewModel.content,
                            validationCondition: {
                                viewModel.hasAppropriateContent
                            }
                        )
                        .lineLimit(inputTextLimit)
                        .padding(.top, Padding.extremelySmall)
                        .id(contentInputScrollIdentifier)
                        .focusing(id: contentInputScrollIdentifier, scrollViewProxy: scrollViewProxy)
                        
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
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity)
                            }
                        )
                        .withTopMediumPadding()
                    }
                    .withTopMediumPadding()
                }
            }
            .padding(.horizontal, Padding.medium)
            .onAppear(perform: { isFocused = true })
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
