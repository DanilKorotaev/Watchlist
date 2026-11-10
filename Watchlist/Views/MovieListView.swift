import SwiftUI

struct MovieListView: View {
    @State private var viewModel: MovieListViewModel

    init(store: WatchlistStore) {
        _viewModel = State(initialValue: MovieListViewModel(store: store))
    }

    var body: some View {
        List {
            ForEach(viewModel.movies) { movie in
                NavigationLink {
                    MovieDetailView(store: viewModel.store, movieID: movie.id)
                } label: {
                    MovieRowView(
                        movie: movie,
                        onFavoriteTap: { viewModel.favoriteButtonTapped(id: movie.id) },
                        onWatchedTap: { viewModel.watchedButtonTapped(id: movie.id) }
                    )
                }
                .navigationLinkIndicatorVisibility(.hidden)
            }
            .onDelete { indexSet in
                viewModel.deleteMovies(at: indexSet)
            }
        }
        .navigationTitle("К просмотру")
        .overlay { emptyOverlay }
        .toolbar { addToolbarItem }
        .sheet(isPresented: Bindable(viewModel).isAddingMovie) {
            addMovieSheet
        }
    }

    @ViewBuilder
    private var emptyOverlay: some View {
        if viewModel.movies.isEmpty {
            ContentUnavailableView(
                "Нет фильмов",
                systemImage: "film",
                description: Text("Нажмите +, чтобы добавить первый фильм.")
            )
        }
    }

    private var addToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button {
                viewModel.addButtonTapped()
            } label: {
                Image(systemName: "plus")
            }
        }
    }

    private var addMovieSheet: some View {
        AddMovieView(store: viewModel.store)
    }
}
