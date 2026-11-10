import SwiftUI

struct MovieRowView: View {
    let movie: Movie

    var body: some View {
        HStack {
            info
            Spacer()
            favoriteIndicator
            watchedIndicator
        }
    }

    private var info: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(movie.title)
                .font(.headline)
                .strikethrough(movie.isWatched)
                .foregroundStyle(movie.isWatched ? .secondary : .primary)
            Text(movie.genre.label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    @ViewBuilder
    private var favoriteIndicator: some View {
        if movie.isFavorite {
            Image(systemName: "heart.fill")
                .foregroundStyle(.red)
        }
    }

    private var watchedIndicator: some View {
        Image(systemName: movie.isWatched ? "checkmark.circle.fill" : "circle")
            .foregroundStyle(movie.isWatched ? .green : .secondary)
    }
}

#Preview {
    MovieRowView(
        movie: Movie(title: "Начало", genre: .sciFi, isFavorite: true)
    )
    .padding()
}
