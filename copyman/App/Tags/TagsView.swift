import SwiftUI
import AnticsUI

struct TagsView: View {
    var body: some View {
        TagLayout(alignment: .leading) {
            // TODO: If there are more than 2 lines -> shrink the view and show [see more...]
            ForEach(0..<3, id: \.self) { i in
                TagView(title: "Tag#\(i)")
            }
            
            Button {
                
            } label: {
                Label("Add new tag", systemImage: "plus.square.dashed")
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
