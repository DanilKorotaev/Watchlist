import SwiftUI

struct MovieListView: View {
    let store: WatchlistStore
    @State private var isAddingMovie = false

    var body: some View {
        List {
            ForEach(store.movies) { movie in
                NavigationLink {
                    MovieDetailView(store: store, movieID: movie.id)
                } label: {
                    MovieRowView(movie: movie)
                }
            }
            .onDelete { indexSet in
                for index in indexSet {
                    store.remove(id: store.movies[index].id)
                }
            }
        }
        .navigationTitle("К просмотру")
        .overlay { emptyOverlay }
        .toolbar { addToolbarItem }
        .sheet(isPresented: $isAddingMovie) {
            addMovieSheet
        }
    }

    @ViewBuilder
    private var emptyOverlay: some View {
        if store.movies.isEmpty {
            ContentUnavailableView(
                "Нет фильмов",
                systemImage: "film",
                description: Text("Нажмите +, чтобы добавить первый фильм.")
            )
        }
    }

    private var addToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button {
                isAddingMovie = true
            } label: {
                Image(systemName: "plus")
            }
        }
    }

    private var addMovieSheet: some View {
        AddMovieView(store: store)
    }
}
