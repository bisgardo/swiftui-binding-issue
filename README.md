# swiftui-binding-issue

Minimal example app for showcasing a crash issue
[discussed on StackOverflow](https://stackoverflow.com/questions/76222170/swiftui-opening-sheet-with-binding-to-new-array-element-fails)
triggered by the usage pattern described below.

The [app](https://github.com/bisgardo/swiftui-binding-issue/blob/main/swiftui-binding-issue/App.swift)
simply allows the user to add a list of text items that the user can edit in a sheet component.
The items are stored in an array in a struct model stored as `@State` in the `App` struct at the root of the app.
A button in the bottom of the screen creates a new item.
The crash occurs if we attempt to make the sheet open the newly created item automatically.

The attempted solution stores a binding (to make the item editable) to the newly created item in a `@State` variable (to make it mutable) of the view.
The variable is optional as the sheet is open iff the value is non-`nil`.

Setting this binding in response to clicking on an existing item works without issues.
But setting it to an item that has just been created (line 25; commented out on `main`) causes the debugger to break on the `@main` annotation with the error

```
Thread 1: Fatal error: Index out of range
```

The log contains the following:

```
Binding<Item>(transaction: SwiftUI.Transaction(plist: []), location: SwiftUI.LocationBox<SwiftUI.FunctionalLocation<swiftui_binding_issue.Item>>, _value: swiftui_binding_issue.Item(id: "New item"))
Binding<Item>(transaction: SwiftUI.Transaction(plist: []), location: SwiftUI.LocationBox<SwiftUI.FunctionalLocation<swiftui_binding_issue.Item>>, _value: swiftui_binding_issue.Item(id: "New item"))
Swift/ContiguousArrayBuffer.swift:600: Fatal error: Index out of range
```
