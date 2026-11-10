import SwiftUI

struct MovieRowView: View {
    let movie: Movie

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title)
                    .font(.headline)
                    .strikethrough(movie.isWatched)
                    .foregroundStyle(movie.isWatched ? .secondary : .primary)
                Text(movie.genre.label)
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
    }
}

#Preview {
    MovieRowView(
        movie: Movie(title: "Начало", genre: .sciFi, isFavorite: true)
    )
    .padding()
}
