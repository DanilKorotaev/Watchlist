import SwiftUI

struct MovieRowView: View {
    let movie: Movie
    var onFavoriteTap: () -> Void
    var onWatchedTap: () -> Void

    private static let dateFormat: Date.FormatStyle = .dateTime.day().month().year()

    var body: some View {
        HStack(spacing: 12) {
            info
            Spacer(minLength: 8)
            favoriteButton
            watchedButton
        }
    }

    private var info: some View {
        VStack(alignment: .leading, spacing: 4) {
            titleText
            genreText
            plannedDateText
        }
    }

    private var titleText: some View {
        Text(movie.title)
            .font(.headline)
            .strikethrough(movie.isWatched)
            .foregroundStyle(movie.isWatched ? .secondary : .primary)
    }

    private var genreText: some View {
        Text(movie.genre.label)
            .font(.caption)
            .foregroundStyle(.secondary)
    }

    @ViewBuilder
    private var plannedDateText: some View {
        if let plannedDate = movie.plannedDate {
            Text(plannedDate.formatted(Self.dateFormat))
                .font(.caption2)
                .foregroundStyle(.tertiary)
        }
    }

    private var favoriteButton: some View {
        Button(action: onFavoriteTap) {
            Image(systemName: movie.isFavorite ? "heart.fill" : "heart")
                .foregroundStyle(movie.isFavorite ? .red : .secondary)
        }
        .buttonStyle(.borderless)
        .accessibilityLabel(movie.isFavorite ? "Убрать из избранного" : "В избранное")
    }

    private var watchedButton: some View {
        Button(action: onWatchedTap) {
            Image(systemName: movie.isWatched ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(movie.isWatched ? .green : .secondary)
        }
        .buttonStyle(.borderless)
        .accessibilityLabel(movie.isWatched ? "Вернуть в очередь" : "Отметить просмотренным")
    }
}

#Preview {
    MovieRowView(
        movie: Movie(title: "Начало", genre: .sciFi, isFavorite: true, plannedDate: .now),
        onFavoriteTap: {},
        onWatchedTap: {}
    )
    .padding()
}
