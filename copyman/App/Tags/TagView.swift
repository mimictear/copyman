import SwiftUI
import AnticsUI

struct TagView: View {
    let title: String
    
    var body: some View {
        Button {
            
        } label: {
            Text(title)
                .applyTextStyle(model: FontStyleModel(font: .footnote, textColor: .white))
                .padding(.horizontal, Padding.small)
                .padding(.vertical, Padding.extremelySmall)
                .foregroundStyle(.white)
                .background(.blue)
                .clipShape(.capsule)
        }
    }
}
