import SwiftUI

struct MovieRowView: View {
    let movie: Movie

    private static let dateFormat: Date.FormatStyle = .dateTime.day().month().year()

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
        movie: Movie(title: "Начало", genre: .sciFi, isFavorite: true, plannedDate: .now)
    )
    .padding()
}
