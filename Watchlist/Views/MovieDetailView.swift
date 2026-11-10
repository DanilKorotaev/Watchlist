import SwiftUI

struct MovieDetailView: View {
    let store: WatchlistStore
    let movieID: UUID

    private var movie: Movie? {
        store.movie(id: movieID)
    }

    var body: some View {
        Group {
            if movie != nil {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        header
                        statusCard
                        actions
                    }
                    .padding()
                }
            } else {
                deletedPlaceholder
            }
        }
        .navigationTitle("Детали")
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    private var header: some View {
        if let movie {
            VStack(alignment: .leading, spacing: 8) {
                Text(movie.title)
                    .font(.largeTitle.bold())
                HStack(spacing: 8) {
                    Text(movie.genre.emoji)
                        .font(.title)
                    Text(movie.genre.title)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }

    @ViewBuilder
    private var statusCard: some View {
        if let movie {
            VStack(alignment: .leading, spacing: 12) {
                Text("Статус")
                    .font(.headline)
                LabeledContent("Просмотр") {
                    Text(movie.isWatched ? "Уже смотрели" : "В очереди")
                        .foregroundStyle(movie.isWatched ? .green : .orange)
                }
                LabeledContent("Избранное") {
                    Text(movie.isFavorite ? "Да" : "Нет")
                        .foregroundStyle(movie.isFavorite ? .red : .secondary)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12))
        }
    }

    private var actions: some View {
        VStack(spacing: 12) {
            watchedButton
            favoriteButton
            deleteButton
        }
    }

    @ViewBuilder
    private var watchedButton: some View {
        if let movie {
            Button {
                store.toggleWatched(id: movieID)
            } label: {
                Label(
                    movie.isWatched ? "Вернуть в очередь" : "Отметить просмотренным",
                    systemImage: movie.isWatched ? "arrow.uturn.backward" : "checkmark.circle"
                )
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
        }
    }

    @ViewBuilder
    private var favoriteButton: some View {
        if let movie {
            Button {
                store.toggleFavorite(id: movieID)
            } label: {
                Label(
                    movie.isFavorite ? "Убрать из избранного" : "В избранное",
                    systemImage: movie.isFavorite ? "heart.slash" : "heart"
                )
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
        }
    }

    private var deleteButton: some View {
        Button(role: .destructive) {
            store.remove(id: movieID)
        } label: {
            Label("Удалить из списка", systemImage: "trash")
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.bordered)
    }

    private var deletedPlaceholder: some View {
        ContentUnavailableView(
            "Фильм удалён",
            systemImage: "trash",
            description: Text("Этой записи больше нет в списке.")
        )
    }
}
