import SwiftUI

struct RootTabView: View {
    let store: WatchlistStore

    var body: some View {
        TabView {
            NavigationStack {
                MovieListView(store: store, filter: .all)
            }
            .tabItem {
                Label(MovieListFilter.all.tabTitle, systemImage: MovieListFilter.all.systemImage)
            }

            NavigationStack {
                MovieListView(store: store, filter: .favorites)
            }
            .tabItem {
                Label(
                    MovieListFilter.favorites.tabTitle,
                    systemImage: MovieListFilter.favorites.systemImage
                )
            }
        }
    }
}
