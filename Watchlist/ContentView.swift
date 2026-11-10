import SwiftUI

struct ContentView: View {
    @State private var store = WatchlistStore()

    var body: some View {
        NavigationStack {
            MovieListView(store: store)
        }
    }
}

#Preview {
    ContentView()
}
