import Foundation

@Observable
final class MovieListViewModel {
    let store: WatchlistStore
    var isAddingMovie = false

    init(store: WatchlistStore) {
        self.store = store
    }

    var movies: [Movie] {
        store.movies
    }

    func addButtonTapped() {
        isAddingMovie = true
    }

    func favoriteButtonTapped(id: UUID) {
        store.toggleFavorite(id: id)
    }

    func watchedButtonTapped(id: UUID) {
        store.toggleWatched(id: id)
    }

    func deleteMovies(at offsets: IndexSet) {
        let ids = offsets.map { movies[$0].id }
        for id in ids {
            store.remove(id: id)
        }
    }
}
