import SwiftUI

enum MovieGenre: String, CaseIterable, Identifiable {
    case action = "🔥 Боевик"
    case comedy = "😄 Комедия"
    case drama = "🎭 Драма"
    case sciFi = "🚀 Фантастика"

    var id: String { rawValue }
}

struct Movie: Identifiable, Equatable {
    let id: UUID
    var title: String
    var genre: MovieGenre
    var isFavorite: Bool
    var isWatched: Bool

    init(
        id: UUID = UUID(),
        title: String,
        genre: MovieGenre,
        isFavorite: Bool = false,
        isWatched: Bool = false
    ) {
        self.id = id
        self.title = title
        self.genre = genre
        self.isFavorite = isFavorite
        self.isWatched = isWatched
    }
}

@Observable
final class WatchlistStore {
    private(set) var movies: [Movie] = [
        Movie(title: "Начало", genre: .sciFi, isFavorite: true),
        Movie(title: "Крёстный отец", genre: .drama),
        Movie(title: "Матрица", genre: .action, isFavorite: true),
        Movie(title: "Один дома", genre: .comedy, isWatched: true)
    ]

    func addMovie(title: String, genre: MovieGenre) {
        movies.append(Movie(title: title, genre: genre))
    }

    func removeMovie(by id: UUID) {
        movies.removeAll { $0.id == id }
    }

    func toggleWatched(by id: UUID) {
        guard let index = movies.firstIndex(where: { $0.id == id }) else { return }
        movies[index].isWatched.toggle()
    }

    func toggleFavorite(by id: UUID) {
        guard let index = movies.firstIndex(where: { $0.id == id }) else { return }
        movies[index].isFavorite.toggle()
    }

    func filterMovies(by genre: MovieGenre) -> [Movie] {
        movies.filter { $0.genre == genre && !$0.isWatched }
    }
}

struct ContentView: View {
    @State private var store = WatchlistStore()

    var body: some View {
        NavigationStack {
            List {
                ForEach(store.movies) { movie in
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(movie.title)
                                .font(.headline)
                                .strikethrough(movie.isWatched)
                                .foregroundStyle(movie.isWatched ? .secondary : .primary)
                            Text(movie.genre.rawValue)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        if movie.isFavorite {
                            Image(systemName: "heart.fill")
                                .foregroundStyle(.red)
                        }
                        Image(systemName: movie.isWatched ? "checkmark.circle.fill" : "circle")
                            .foregroundStyle(movie.isWatched ? .green : .secondary)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        store.toggleWatched(by: movie.id)
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        store.removeMovie(by: store.movies[index].id)
                    }
                }
            }
            .navigationTitle("К просмотру")
            .toolbar {
                Button {
                    store.addMovie(title: "Новый фильм", genre: .drama)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
