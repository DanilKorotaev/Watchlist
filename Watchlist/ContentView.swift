import SwiftUI

struct ContentView: View {
    @State private var store = WatchlistStore()

    var body: some View {
        RootTabView(store: store)
    }
}

#Preview {
    ContentView()
}
