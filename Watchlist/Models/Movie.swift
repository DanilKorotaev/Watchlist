import Foundation

struct Movie: Identifiable, Equatable {
    let id: UUID
    var title: String
    var genre: MovieGenre
    var isFavorite: Bool
    var isWatched: Bool
    var plannedDate: Date?

    init(
        id: UUID = UUID(),
        title: String,
        genre: MovieGenre,
        isFavorite: Bool = false,
        isWatched: Bool = false,
        plannedDate: Date? = nil
    ) {
        self.id = id
        self.title = title
        self.genre = genre
        self.isFavorite = isFavorite
        self.isWatched = isWatched
        self.plannedDate = plannedDate
    }
}
