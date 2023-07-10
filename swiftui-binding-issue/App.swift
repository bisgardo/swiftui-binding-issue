import SwiftUI

struct Model {
    var items: [Item]
}

struct Item: Identifiable {
    var id: String
}

struct MainView: View {
    @Binding var model: Model
    @State private var editItem: Binding<Item>?

    var body: some View {
        VStack {
            List($model.items) { $item in
                Button(action: { editItem = $item }) {
                    Text($item.wrappedValue.id)
                }
            }
            Button(action: {
                model.items.append(Item(id: "New item"))
                // Store binding to newly created item to open it in the sheet.
//                editItem = $model.items.last // UNCOMMENTING THIS CAUSES CRASH
            }) {
                Image(systemName: "plus").font(.system(size: 45))
            }
        }.sheet(item: $editItem) { $item in
            let _ = print($item)
            ItemEditView(item: $item)
        }
    }
}

struct ItemEditView: View {
    @Binding var item: Item
    @State private var editingItem: Item = Item(id: "dummy")

    var body: some View {
        TextField("Title", text: $editingItem.id)
            .onAppear {
                editingItem = item
            }
            .onDisappear {
                item = editingItem
            }
    }
}

@main
struct MyApp: App {
    @State var model = Model(items: [])

    var body: some Scene {
        WindowGroup {
            MainView(model: $model)
        }
    }
}
