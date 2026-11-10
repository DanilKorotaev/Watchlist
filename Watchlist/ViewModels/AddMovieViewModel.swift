import Foundation

@Observable
final class AddMovieViewModel {
    private let store: WatchlistStore

    var title: String = ""
    var genre: MovieGenre = .drama
    var markAsFavorite = false

    init(store: WatchlistStore) {
        self.store = store
    }

    var canSave: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func saveButtonTapped() {
        let cleaned = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cleaned.isEmpty else { return }
        store.add(
            Movie(
                title: cleaned,
                genre: genre,
                isFavorite: markAsFavorite
            )
        )
        title = ""
        genre = .drama
        markAsFavorite = false
    }
}
