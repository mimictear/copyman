import Storage
import SwiftUI

struct EditItemSheet: View {
    let item: ItemModel
    
    var body: some View {
        ItemSheet(operation: .edit(item))
    }
}
