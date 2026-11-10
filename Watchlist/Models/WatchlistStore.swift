import Foundation

@Observable
final class WatchlistStore {
    private(set) var movies: [Movie] = [
        Movie(title: "Начало", genre: .sciFi, isFavorite: true),
        Movie(title: "Крёстный отец", genre: .drama),
        Movie(title: "Матрица", genre: .action, isFavorite: true),
        Movie(title: "Один дома", genre: .comedy, isWatched: true)
    ]

    var favorites: [Movie] {
        movies.filter { $0.isFavorite }
    }

    func movie(id: UUID) -> Movie? {
        movies.first { $0.id == id }
    }

    func add(_ movie: Movie) {
        movies.append(movie)
    }

    func toggleFavorite(id: UUID) {
        guard let index = movies.firstIndex(where: { $0.id == id }) else { return }
        movies[index].isFavorite.toggle()
    }

    func toggleWatched(id: UUID) {
        guard let index = movies.firstIndex(where: { $0.id == id }) else { return }
        movies[index].isWatched.toggle()
    }

    func setPlannedDate(id: UUID, date: Date?) {
        guard let index = movies.firstIndex(where: { $0.id == id }) else { return }
        movies[index].plannedDate = date
    }

    func remove(id: UUID) {
        movies.removeAll { $0.id == id }
    }

    func filterMovies(by genre: MovieGenre) -> [Movie] {
        movies.filter { $0.genre == genre && !$0.isWatched }
    }
}
