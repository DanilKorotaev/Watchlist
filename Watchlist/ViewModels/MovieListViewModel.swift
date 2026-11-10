import Foundation

@Observable
final class MovieListViewModel {
    let store: WatchlistStore
    let filter: MovieListFilter
    var isAddingMovie = false

    init(store: WatchlistStore, filter: MovieListFilter = .all) {
        self.store = store
        self.filter = filter
    }

    var movies: [Movie] {
        switch filter {
        case .all:
            store.movies
        case .favorites:
            store.favorites
        }
    }

    var title: String {
        filter.title
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
