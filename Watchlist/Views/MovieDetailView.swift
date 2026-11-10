import SwiftUI

struct MovieDetailView: View {
    @State private var viewModel: MovieDetailViewModel

    private static let dateFormat: Date.FormatStyle = .dateTime.day().month().year()

    init(store: WatchlistStore, movieID: UUID) {
        _viewModel = State(initialValue: MovieDetailViewModel(store: store, movieID: movieID))
    }

    private var movie: Movie? {
        viewModel.movie
    }

    var body: some View {
        Group {
            if movie != nil {
                loadedContent
                    .sheet(isPresented: Bindable(viewModel).isPickingDate) {
                        planDateSheet
                    }
            } else {
                deletedPlaceholder
            }
        }
        .navigationTitle("Детали")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var loadedContent: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                header
                statusCard
                planSection
                actions
            }
            .padding()
        }
    }

    private var planDateSheet: some View {
        DatePickerSheet(
            title: "Когда смотрим?",
            initialDate: movie?.plannedDate ?? .now,
            onSelect: { date in
                viewModel.dateSelected(date)
            },
            onClear: {
                viewModel.dateCleared()
            }
        )
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

    @ViewBuilder
    private var planSection: some View {
        if let movie {
            VStack(alignment: .leading, spacing: 12) {
                Text("План")
                    .font(.headline)
                if let plannedDate = movie.plannedDate {
                    Text("Смотрим \(plannedDate.formatted(Self.dateFormat))")
                        .foregroundStyle(.secondary)
                } else {
                    Text("Дата ещё не выбрана")
                        .foregroundStyle(.secondary)
                }
                planDateButton
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12))
        }
    }

    @ViewBuilder
    private var planDateButton: some View {
        if let movie {
            Button {
                viewModel.planDateButtonTapped()
            } label: {
                Label(
                    movie.plannedDate == nil ? "Выбрать дату" : "Изменить дату",
                    systemImage: "calendar"
                )
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
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
                viewModel.watchedButtonTapped()
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
                viewModel.favoriteButtonTapped()
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
            viewModel.deleteButtonTapped()
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
