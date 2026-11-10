import Foundation

@Observable
final class MovieDetailViewModel {
    private let store: WatchlistStore
    let movieID: UUID
    var isPickingDate = false

    init(store: WatchlistStore, movieID: UUID) {
        self.store = store
        self.movieID = movieID
    }

    var movie: Movie? {
        store.movie(id: movieID)
    }

    func watchedButtonTapped() {
        store.toggleWatched(id: movieID)
    }

    func favoriteButtonTapped() {
        store.toggleFavorite(id: movieID)
    }

    func deleteButtonTapped() {
        store.remove(id: movieID)
    }

    func planDateButtonTapped() {
        isPickingDate = true
    }

    func dateSelected(_ date: Date) {
        store.setPlannedDate(id: movieID, date: date)
        isPickingDate = false
    }

    func dateCleared() {
        store.setPlannedDate(id: movieID, date: nil)
        isPickingDate = false
    }
}
